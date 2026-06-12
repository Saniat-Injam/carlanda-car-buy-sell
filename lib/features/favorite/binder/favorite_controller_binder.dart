import 'package:carlanda_car_buy_sell/features/favorite/controller/favorite_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';

class FavoriteControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
  }
}
