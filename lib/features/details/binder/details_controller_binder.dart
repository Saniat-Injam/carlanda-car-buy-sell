import 'package:carlanda_car_buy_sell/features/details/controller/delivery_information_controller.dart';
import 'package:carlanda_car_buy_sell/features/details/controller/details_controller.dart';
import 'package:get/get.dart';

class DetailsControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailsController>(() => DetailsController(), fenix: true);
    Get.lazyPut<DeliveryInformationController>(
      () => DeliveryInformationController(),
      fenix: true,
    );
  }
}
