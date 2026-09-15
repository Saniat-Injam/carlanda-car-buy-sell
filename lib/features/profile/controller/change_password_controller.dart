import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/common/widgets/loading_progress_indicator.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../../../routes/app_routes.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  var existingPasswordVisibility = true.obs;
  var newPasswordVisibility = true.obs;
  var confirmPasswordVisibility = true.obs;

  var existingPassHasError = false.obs;
  var newPassHasError = false.obs;
  var confirmPassHasError = false.obs;

  var errorMessage = ''.obs;

  late TextEditingController existingPassController;
  late TextEditingController newPassController;
  late TextEditingController confirmPassController;

  @override
  void onInit() {
    super.onInit();
    existingPassController = TextEditingController();
    newPassController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  void toggleExistingPassVisibility() =>
      existingPasswordVisibility.value = !existingPasswordVisibility.value;

  void toggleNewPassVisibility() =>
      newPasswordVisibility.value = !newPasswordVisibility.value;

  void toggleConfirmPassVisibility() =>
      confirmPasswordVisibility.value = !confirmPasswordVisibility.value;

  bool validatePassword({
    required String existingPass,
    required String newPass,
    required String confirmPass,
  }) {
    String? existingPassError = existingPass.isEmpty
        ? "Existing password is required."
        : null;

    String? newPassError = newPass.length < 6
        ? "Password must be at least 6 characters."
        : null;

    String? confirmPassError = confirmPass.isEmpty
        ? "Confirm password is required."
        : confirmPass != newPass
        ? "Confirm password doesn't match the new password."
        : null;

    bool hasError =
        existingPassError != null ||
        newPassError != null ||
        confirmPassError != null;

    existingPassHasError.value = existingPassError != null;
    newPassHasError.value = newPassError != null;
    confirmPassHasError.value = confirmPassError != null;

    errorMessage.value =
        existingPassError ?? newPassError ?? confirmPassError ?? "";

    return !hasError;
  }

  Future<void> changePassword() async {
    String existingPass = existingPassController.text.trim();
    String newPass = newPassController.text.trim();
    String confirmPass = confirmPassController.text.trim();

    // Validate passwords
    if (!validatePassword(
      existingPass: existingPass,
      newPass: newPass,
      confirmPass: confirmPass,
    )) {
      return;
    }

    try {
      isLoading.value = true;

      final token = AuthService.token;
      if (token == null || token.isEmpty) {
        AppSnackBar.showError(
          "You are not authenticated. Please log in again.",
        );
        return;
      }

      final requestBody = {"currentPass": existingPass, "newPass": newPass};

      loadingProgressIndicator(title: "Updating password...");

      final response = await NetworkCaller().patchRequest(
        AppUrls.updatePassword,
        body: requestBody,
        token: "Bearer $token",
      );

      Get.back(); // close loader

      log("📩 Response: ${response.responseData}");

      if (response.isSuccess) {
        AppSnackBar.showSuccess("Password changed successfully");

        // optionally navigate back to login
        Get.offAllNamed(AppRoute.loginScreen);
      } else {
        AppSnackBar.showError(
          response.errorMessage ?? "Password change failed",
        );
      }
    } catch (error) {
      Get.back();
      AppLoggerHelper.error("Error changing password: $error");
      AppSnackBar.showError("An unexpected error occurred. Try again.");
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> changePassword() async {
  //   String existingPass = existingPassController.text.trim();
  //   String newPass = newPassController.text.trim();
  //   String confirmPass = confirmPassController.text.trim();
  //
  //   if (!validatePassword(
  //     existingPass: existingPass,
  //     newPass: newPass,
  //     confirmPass: confirmPass,
  //   )) {
  //     return;
  //   }
  //   isLoading.value = true;
  //
  //   final response = await NetworkCaller().patchRequest(
  //     AppUrls.updatePassword,
  //     body: {"currentPass": existingPass.text},
  //     token: "Bearer ${AuthService.token}",
  //   );
  //   isLoading.value = false;
  //   Get.snackbar(
  //     "Success",
  //     "Password changed successfully",
  //     backgroundColor: AppColors.success,
  //     colorText: AppColors.textWhite,
  //   );
  // }

  @override
  void onClose() {
    existingPassController.dispose();
    newPassController.dispose();

    super.onClose();
  }
}
