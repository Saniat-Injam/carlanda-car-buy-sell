import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/common/widgets/app_snack_bar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/loading_progress_indicator.dart';
import 'package:carlanda_car_buy_sell/core/services/Auth_service.dart';
import 'package:carlanda_car_buy_sell/core/services/network_caller.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_urls.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/change_pass_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // Text Controllers
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  // Observable variables
  final RxBool newPasswordObscure = true.obs;
  final RxBool confirmPasswordObscure = true.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  
  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
  
  void toggleNewPasswordVisibility() {
    newPasswordObscure.value = !newPasswordObscure.value;
  }
  
  void toggleConfirmPasswordVisibility() {
    confirmPasswordObscure.value = !confirmPasswordObscure.value;
  }
  
  void clearErrors() {
    errorMessage.value = '';
  }
  
  Future<void> resetPassword() async {
    // Clear previous errors
    clearErrors();
    
    // Basic validation
    if (newPasswordController.text.trim().isEmpty) {
      errorMessage.value = 'New password is required';
      return;
    }
    
    if (confirmPasswordController.text.trim().isEmpty) {
      errorMessage.value = 'Confirm password is required';
      return;
    }
    
    if (newPasswordController.text.trim().length < 6) {
      errorMessage.value = 'Password must be at least 6 characters';
      return;
    }
    
    if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
      errorMessage.value = 'Passwords do not match';
      return;
    }

    final requestBody = {
      "newPassword": newPasswordController.text
    };
    
    try {
      isLoading.value = true;
      loadingProgressIndicator();
      await AuthService.init();
      log("The token is: ${AuthService.token}");
      final response = await NetworkCaller().postRequest(AppUrls.resetPassword, body: requestBody, token: "Bearer ${AuthService.token}");

      if(response.isSuccess){
        Get.back();
        Get.offAllNamed(ChangePassSuccessScreen.routeName);
        AppSnackBar.showSuccess("Password reset successfully");
      }
      else{
        Get.back();
        AppSnackBar.showSuccess("Failed to reset password. Please try again.");
        log("Status code: ${response.statusCode}");
      }
      // On success, navigate to success screen
      
    } catch (e) {
      errorMessage.value = 'Failed to reset password. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }
}
