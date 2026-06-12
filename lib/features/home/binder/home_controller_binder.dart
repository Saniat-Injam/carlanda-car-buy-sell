import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
