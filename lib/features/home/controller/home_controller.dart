import 'dart:developer';
import 'package:carlanda_car_buy_sell/features/home/data/model/car_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/services/Auth_service.dart';
import '../../../../core/services/network_caller.dart';
import '../../../../core/utils/constants/app_urls.dart';
import '../../../core/common/entity/car_entity.dart';
import '../../../core/common/widgets/app_snack_bar.dart';
import '../data/model/user_profile_response.dart';
import '../data/model/weekly_deals_model.dart';
class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isFeaturedCarsLoading = false.obs;
  RxBool isFeaturedCarsPaginationLoading = false.obs;

  var featuredCars = <CarEntity>[].obs;

  var fetchedInformation = UserProfileResponse();
  var featuredCarsResponse = Rx<CarModel?>(null);
  var featuredCarsCurrentPage = 1.obs;
  var featuredCarsTotalItems = 0.obs;
  var featuredCarsTotalPages = 0.obs;
  final featuredCarsPerPageLimit = 10;

  final featuredCarsScrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();

    featuredCarsScrollController.addListener(() async {
      if (featuredCarsScrollController.position.pixels >=
          featuredCarsScrollController.position.maxScrollExtent) {
        if (!isFeaturedCarsPaginationLoading.value &&
            featuredCars.length < featuredCarsTotalItems.value) {
          await loadMoreFeaturedCars();
        }
      }
    });
    await getFeaturedCars();
    loadMoreFeaturedCars();
    await getWeekendDeals();
  }

  @override
  void onClose() {
    featuredCarsScrollController.dispose();
    super.onClose();
  }

  /// Convert CarModel to CarEntity
  CarEntity _convertToEntity(CarModel model) {
    String imagePath = '';
    if (model.carImages != null && model.carImages!.isNotEmpty) {
      imagePath = model.carImages!.first;
    }

    double displayPrice = (model.discountPrice ?? model.price ?? 0).toDouble();
    String title = '${model.carName ?? ''} ${model.carModel ?? ''}'.trim();

    if (title.isEmpty) {
      title = 'Unknown Car';
    }

    return CarEntity(
      id: model.id ?? '',
      title: title,
      imagePath: imagePath,
      price: displayPrice,
      year: model.registrationYear?.toString() ?? '0',
      mileage: model.mileage ?? 0,
      location: model.carLocation ?? '',
      isFavorite: false,
      chatRoomId: '',
      phoneNumber: 0,
      whatsappNumber: 0,
    );
  }

  List<CarEntity> _convertToEntityList(List<CarModel> models) {
    return models.map((model) => _convertToEntity(model)).toList();
  }

  Future<void> getFeaturedCars() async {
    try {
      isFeaturedCarsLoading.value = true;
      featuredCarsCurrentPage.value = 1;
      featuredCars.clear();

      final response = await NetworkCaller().getRequest(
        "${AppUrls.getAllCar}?page=${featuredCarsCurrentPage.value}&limit=$featuredCarsPerPageLimit",
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {

        final carResponse = CarResponseModel.fromJson(response.responseData);

        if (carResponse.data != null && carResponse.data!.data != null) {
          List<CarEntity> entities = _convertToEntityList(
            carResponse.data!.data!,
          );
          featuredCars.value = entities;
          if (carResponse.data!.meta != null) {
            featuredCarsTotalItems.value = carResponse.data!.meta!.total ?? 0;
            featuredCarsTotalPages.value =
                carResponse.data!.meta!.totalPages ?? 0;
            featuredCarsCurrentPage.value++;
          }
        }
      } else {
        AppSnackBar.showError("Failed to load featured cars");
        log("API Error: ${response.statusCode}");
      }
    } catch (e) {
      AppSnackBar.showError("Error loading featured cars");
      log("Exception in getFeaturedCars: ${e.toString()}");
    } finally {
      isFeaturedCarsLoading.value = false;
    }
  }

  Future<void> loadMoreFeaturedCars() async {
    if (isFeaturedCarsPaginationLoading.value) return;

    try {
      isFeaturedCarsPaginationLoading.value = true;

      final response = await NetworkCaller().getRequest(
        "${AppUrls.getAllCar}?page=${featuredCarsCurrentPage.value}&limit=$featuredCarsPerPageLimit",
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {
        final carResponse = CarResponseModel.fromJson(response.responseData);

        if (carResponse.data != null &&
            carResponse.data!.data != null &&
            carResponse.data!.data!.isNotEmpty) {
          List<CarEntity> newEntities = _convertToEntityList(
            carResponse.data!.data!,
          );
          featuredCars.addAll(newEntities);

          if (carResponse.data!.meta != null) {
            featuredCarsTotalItems.value = carResponse.data!.meta!.total ?? 0;
            featuredCarsTotalPages.value =
                carResponse.data!.meta!.totalPages ?? 0;
          }

          featuredCarsCurrentPage.value++;

        }
      } else {
        AppSnackBar.showError("Failed to load more cars");
        log("Pagination API Error: ${response.statusCode}");
      }
    } catch (e) {
      AppSnackBar.showError("Error loading more cars");
      log("Exception in loadMoreFeaturedCars: ${e.toString()}");
    } finally {
      isFeaturedCarsPaginationLoading.value = false;
    }
  }

  Future<void> refreshFeaturedCars() async {
    await getFeaturedCars();
  }
  var deals = <Deal>[].obs;
  Future<void> getWeekendDeals() async {
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getWeeklyDeals,
        token: "Bearer ${AuthService.token}",
      );
      if (response.isSuccess) {
        final data = response.responseData;
        deals.value = (data['data'] as List)
            .map((deal) => Deal.fromJson(deal))
            .toList();
      } else {
        AppSnackBar.showError("Failed to fetch weekly deals");
        log("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      AppSnackBar.showError("Error fetching weekly deals");
      log("Exception in getWeekendDeals: ${e.toString()}");
    }
  }
  bool get canLoadMoreFeaturedCars =>
      featuredCars.length < featuredCarsTotalItems.value;
}
