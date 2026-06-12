import 'package:carlanda_car_buy_sell/features/profile_setup/controller/profile_setup_controller.dart';
import 'package:get/get.dart';

class ProfileStupBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileSetupController>(
      () => ProfileSetupController(),
      fenix: true,
    );
  }
}
