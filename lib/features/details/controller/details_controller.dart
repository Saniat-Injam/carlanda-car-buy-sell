import 'dart:developer';
import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/features/home/data/model/car_model.dart';
import 'package:get/get.dart';
import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/services/Auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class DetailsController extends GetxController {
  Rx<DeliveryOptions?> selectedOption = Rx<DeliveryOptions?>(null);
  void selectDeliveryOption({required DeliveryOptions option}) => selectedOption.value = option;
  Rx<PaymentOptions?> selectedPaymentOption = Rx<PaymentOptions?>(null);
  void selectPaymentOption({required PaymentOptions option}) =>
      selectedPaymentOption.value = option;
  @override
  void onInit() {
    super.onInit();
    final String carId = Get.arguments['carId'] ?? '';
    if (carId.isNotEmpty) {
      getCarById(carId);
    }
  }

  var carDetails = Rx<CarModel?>(null);
  var fetchedInformation = CarModel();
  Future<void> getCarById(String carId) async {
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getCarById(carId: 'carId'),
        token: "Bearer ${AuthService.token}",
      );
      if (response.isSuccess)
      {
        final data = response.responseData;
        fetchedInformation = CarModel.fromJson(data);
        log("Car id is: ${AuthService.id}");
        log("Car information fetched successfully");
        log(fetchedInformation.toString());
      }
      else {
        AppSnackBar.showError("Failed to fetch car information");
        log("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      AppSnackBar.showError("Error fetching car information");
      log("Exception in getMe: ${e.toString()}");
    }
  }
}
