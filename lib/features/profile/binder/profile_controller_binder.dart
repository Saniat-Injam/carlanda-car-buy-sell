import 'package:carlanda_car_buy_sell/features/profile/controller/change_password_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/language_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/my_booking_car_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/my_history_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/personal_information_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/profile_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

class ProfileControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<PersonalInformationController>(
      () => PersonalInformationController(),
      fenix: true,
    );
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(),
      fenix: true,
    );
    Get.lazyPut<MyHistoryController>(() => MyHistoryController(), fenix: true);
    Get.lazyPut<LanguageController>(() => LanguageController(), fenix: true);
    Get.lazyPut<MyBookingCarController>(() => MyBookingCarController(), fenix: true);
  }
}
