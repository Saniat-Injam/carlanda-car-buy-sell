import 'dart:developer';

import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/services/Auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class ForgetPasswordController extends GetxController {
  // Text Controllers
  final TextEditingController emailController = TextEditingController();

  // Observable variables
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void clearErrors() {
    errorMessage.value = '';
  }

  Future<void> forgetPassword() async {
    clearErrors();

    if (emailController.text.trim().isEmpty) {
      errorMessage.value = 'Email is required';
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      errorMessage.value = 'Please enter a valid email';
      return;
    }

    try {
      isLoading.value = true;

      final requestBody = {
        "email": emailController.text.toLowerCase(),
      };
      log(requestBody.toString());
      final response = await NetworkCaller().postRequest(
        AppUrls.forgotPassword,
        body: requestBody,
      );
      if(response.isSuccess){
        Get.back();
        final data = response.responseData;
        final String userId = data['data']['userId'].toString();

        await AuthService.saveId(userId);
        Get.toNamed(
          OtpVerificationScreen.routeName,
          arguments: {
            'userId': userId,
            'email' : emailController.text.toLowerCase(),
            'isSignup' : false,
          },
        );
      }
      else{
        AppSnackBar.showError("Wrong email!!");
        log(response.statusCode.toString());
      }

    } catch (e) {
      errorMessage.value = 'Failed to send email. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
///