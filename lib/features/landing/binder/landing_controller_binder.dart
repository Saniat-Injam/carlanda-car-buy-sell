import 'package:carlanda_car_buy_sell/features/landing/controller/landing_controller.dart';
import 'package:get/get.dart';

class LandingControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingController(), fenix: true);
  }
}
