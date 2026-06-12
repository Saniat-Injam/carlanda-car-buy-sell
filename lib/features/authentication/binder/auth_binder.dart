import 'package:carlanda_car_buy_sell/features/authentication/controllers/forget_password_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/login_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/otp_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/reset_password_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/sign_up_controller.dart';
import 'package:get/get.dart';

class AuthBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController(), fenix: true);
    Get.lazyPut<OtpController>(() => OtpController(), fenix: true);
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController(), fenix: true);
  }
}
