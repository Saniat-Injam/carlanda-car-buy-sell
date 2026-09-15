import 'dart:async';
import 'dart:developer';
import 'package:carlanda_car_buy_sell/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/common/widgets/loading_progress_indicator.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../presentation/screens/reset_password_screen.dart';

class OtpController extends GetxController {
  final TextEditingController pinController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxInt timerSeconds = 120.obs;
  final RxString otp = ''.obs;

  var userEmail = '';
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    startTimer();
    final args = Get.arguments as Map?;
    if (args != null) {
      if (args['userId'] != null) {
        userId.value = args['userId'].toString();
      } else {}
      if (args['email'] != null) {
        email.value = args['email'].toString();
      } else {}
    } else {}
  }

  @override
  void onClose() {
    pinController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    timerSeconds.value = 120;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void setOtp(String value) {
    otp.value = value;
  }

  var userId = "".obs;
  final userIdTEController = TextEditingController();
  final otpTEController = TextEditingController();
  Future<void> verifyOtp(String nextRoute, bool isSignUp) async {
    if (userId.value.isEmpty) {
      final args = Get.arguments as Map?;
      if (args != null && args['userId'] != null) {
        userId.value = args['userId'].toString();
      }
    }
    if (otp.value.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter complete OTP',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (userId.value.isEmpty) {
      Get.snackbar(
        'Error',
        'User ID not found. Please try signing up again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;
      final requestBody = {
        "userId": userId.value,
        "otpCode": int.parse(otp.value),
      };

      loadingProgressIndicator(title: "Verifying...");

      final response = await NetworkCaller().postRequest(
        AppUrls.userRegisterOtp,
        body: requestBody,
      );

      Get.back();

      if (response.isSuccess) {
        final data = response.responseData['data'];
        await AuthService.init();
        await AuthService.saveToken(data['accessToken']);
        log("The saved token is: ${AuthService.token.toString()}");
        AppSnackBar.showSuccess("Verify otp successfully");
        Get.offAllNamed(nextRoute, arguments: {"isSignUp": isSignUp});
      } else if (response.statusCode == 409) {
        AppSnackBar.showError(response.errorMessage);
      } else if (response.statusCode == 404) {
        log(' OTP: ${response.errorMessage}');
        AppSnackBar.showError("Invalid OTP. Please try again.");
      } else if (response.statusCode == 408) {
        log(' OTP: ${response.errorMessage}');
        AppSnackBar.showError("OTP Expired. Please try again.");
      } else {
        AppSnackBar.showError(response.errorMessage);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Invalid OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// For reset password
  Future<void> verifyLoginOtp() async {
    if (userId.value.isEmpty) {
      final args = Get.arguments as Map?;
      if (args != null && args['userId'] != null) {
        userId.value = args['userId'].toString();
      }
    }

    if (userId.value.isEmpty) {
      Get.snackbar(
        'Error',
        'User ID not found. Please log in again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (otp.value.isEmpty || otp.value.length != 6) {
      Get.snackbar(
        'Error',
        'Please enter a valid 6-digit OTP.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final requestBody = {
        "userId": userId.value,
        "otpCode": int.parse(otp.value),
      };

      loadingProgressIndicator(title: "Verifying OTP...");

      final response = await NetworkCaller().postRequest(
        AppUrls.verifyOtp,
        body: requestBody,
      );

      Get.back();

      if (response.isSuccess) {
        final data = response.responseData['data'];
        await AuthService.init();
        await AuthService.saveToken(data['accessToken']);
        AppSnackBar.showSuccess("OTP Verified successfully");

        Future.delayed(const Duration(milliseconds: 200), () {
          Get.offAllNamed(ResetPasswordScreen.routeName);
        });
      } else if (response.statusCode == 404) {
        log(' OTP: ${response.errorMessage}');
        AppSnackBar.showError("Invalid OTP. Please try again.");
      } else if (response.statusCode == 408) {
        log(' OTP: ${response.errorMessage}');
        AppSnackBar.showError("OTP Expired. Please try again.");
      } else {
        AppSnackBar.showError(
          response.errorMessage ?? 'Unknown error occurred.',
        );
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'An error occurred while verifying OTP. Please try again.',
        backgroundColor: AppColors.error,
        colorText: AppColors.textWhite,
      );
      log('Error during OTP verification: $e');
    } finally {
      isLoading.value = false;
    }
  }

  final RxString email = ''.obs;
  final TextEditingController emailController = TextEditingController();
  Future<void> resendOtp() async {
    if (email.value.isEmpty) {
      final args = Get.arguments as Map?;
      if (args != null && args['email'] != null) {
        email.value = args['email'].toString();
        log('📧 Email retrieved from arguments: ${email.value}');
      }
    }

    if (email.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email not found. Please try signing up again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final requestBody = {"email": email.value.toLowerCase()};

      loadingProgressIndicator(title: "Resending OTP...");

      final response = await NetworkCaller().postRequest(
        AppUrls.resendOtp,
        body: requestBody,
      );

      Get.back();

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['userId'] != null) {
          userId.value = data['userId'].toString();
        }
        _timer?.cancel();
        startTimer();

        pinController.clear();
        otp.value = '';

        AppSnackBar.showSuccess('OTP has been resent to your email');
      } else {
        AppSnackBar.showError(response.errorMessage);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Error',
        'Failed to resend OTP. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
