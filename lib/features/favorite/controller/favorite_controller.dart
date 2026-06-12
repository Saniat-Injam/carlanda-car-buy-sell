import 'dart:developer';
import 'package:carlanda_car_buy_sell/core/common/entity/car_entity.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:carlanda_car_buy_sell/features/favorite/data/model/favorite_items_model.dart';
import 'package:get/get.dart';
import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/services/Auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class FavoriteController extends GetxController {
  final List<CarEntity> favoriteCars = <CarEntity>[
    CarEntity(
      id: "1",
      imagePath: WillDPictures.cars1,
      title: "Audi . RS Q8 . TFSI V8",
      price: 24000,
      year: "2025",
      isFavorite: true,
      mileage: 1700,
      location: "Ras AI Khor, Dubai",
      chatRoomId: "",
      phoneNumber: 0188,
      whatsappNumber: 10111,
    ),
    CarEntity(
      id: "1",
      imagePath: WillDPictures.cars2,
      title: "Audi . RS Q8 . TFSI V8",
      price: 24000,
      year: "2025",
      isFavorite: true,
      mileage: 1700,
      location: "Ras AI Khor, Dubai",
      chatRoomId: "",
      phoneNumber: 0188,
      whatsappNumber: 10111,
    ),
    CarEntity(
      id: "1",
      imagePath: WillDPictures.cars4,
      title: "Audi . RS Q8 . TFSI V8",
      price: 24000,
      year: "2025",
      isFavorite: true,
      mileage: 1700,
      location: "Ras AI Khor, Dubai",
      chatRoomId: "",
      phoneNumber: 0188,
      whatsappNumber: 10111,
    ),
  ];
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAllFavoriteItems();
  }
  var data = <FavouriteItemsResponse>[].obs;
  Future<void> getAllFavoriteItems() async {
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getAllFavoriteItems,
        token: "Bearer ${AuthService.token}",
      );
      if (response.isSuccess) {
        final data = response.responseData;
      }
      else {
        AppSnackBar.showError("Failed to fetch track order");
        log("Error status code: ${response.statusCode}");
      }
    }
    catch (e) {
      AppSnackBar.showError("Error fetching order track");
      log("Exception in getWeekendDeals: ${e.toString()}");
    }
  }
}
