import 'package:carlanda_car_buy_sell/features/view_cars/controller/view_cars_controller.dart';
import 'package:get/get.dart';

class ViewCarsControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewCarsController>(() => ViewCarsController(), fenix: true);
  }
}
