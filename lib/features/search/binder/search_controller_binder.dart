import 'package:carlanda_car_buy_sell/features/search/controller/search_screen_controller.dart';
import 'package:get/get.dart';

class SearchControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchScreenController>(
      () => SearchScreenController(),
      fenix: true,
    );
  }
}
