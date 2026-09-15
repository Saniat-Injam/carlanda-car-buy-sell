import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/utils/logging/logger.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/social_authentication_controller.dart';
import 'package:carlanda_car_buy_sell/features/landing/presentation/view/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/common/widgets/loading_progress_indicator.dart';
import '../../../core/services/Auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool obscureText = true.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  void clearErrors() {
    errorMessage.value = '';
  }

  final socialAuthenticationController = Get.put(
    () => SocialAuthenticationController(),
  );

  void fetchSocialInfo() async {
    try {
      final authInfo = await socialAuthenticationController()
          .signInWithGoogle();

      if (authInfo != null) {
        socialLogin(email: authInfo.user!.email!);
      }
    } catch (error) {
      AppSnackBar.showError("Failed to login!");
      AppLoggerHelper.error(error.toString());
    }
  }

  Future<void> socialLogin({required String email}) async {
    try {
      final requestBody = {"email": email.toLowerCase(), "fcmToken": ""};

      loadingProgressIndicator();
      final response = await NetworkCaller().postRequest(
        AppUrls.socialLogin,
        body: requestBody,
      );

      if (response.isSuccess) {
        Get.back();

        final data = response.responseData;

        final String userId = data['data']['userId'].toString();
        final String accessToken = data['data']['accessToken'];

        await AuthService.saveId(userId);
        await AuthService.saveAccessToken(accessToken);

        AppSnackBar.showSuccess("User logged in successfully");
        Get.offAllNamed(LandingScreen.routeName);
      } else {
        Get.back();
        errorMessage.value =
            response.errorMessage ?? 'Login failed. Please try again.';
      }
    } catch (error) {
      AppSnackBar.showError(error.toString());
    }
  }

  Future<void> login() async {
    clearErrors();

    if (emailController.text.trim().isEmpty) {
      errorMessage.value = 'Email is required';
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      errorMessage.value = 'Password is required';
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
        "password": passwordController.text,
      };

      log('Login request body: $requestBody');

      loadingProgressIndicator();

      final response = await NetworkCaller().postRequest(
        AppUrls.login,
        body: requestBody,
        token: "Bearer ${AuthService.token}",
      );

      if (response.isSuccess) {
        Get.back();

        final data = response.responseData;

        final String userId = data['data']['userId'].toString();
        final String accessToken = data['data']['accessToken'];

        await AuthService.saveId(userId);
        await AuthService.saveAccessToken(accessToken);

        AppSnackBar.showSuccess("User logged in successfully");
        Get.offAllNamed(LandingScreen.routeName);
      } else {
        Get.back();
        errorMessage.value =
            response.errorMessage ?? 'Login failed. Please try again.';
      }
    } catch (e) {
      Get.back();
      log('Error during login: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
