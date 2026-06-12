import 'dart:developer';

import 'package:carlanda_car_buy_sell/features/authentication/controllers/social_authentication_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/change_pass_success_screen.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/common/widgets/loading_progress_indicator.dart';
import '../../../core/services/Auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../../landing/presentation/view/landing_screen.dart';

class SignUpController extends GetxController {
  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable variables
  final RxBool obscureText = true.obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onClose() {
    nameController.dispose();
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

  final socialAuthenticationController = Get.put(() => SocialAuthenticationController());

  void fetchSocialInfo() async{

    try{
      final authInfo = await socialAuthenticationController().signInWithGoogle();

      if(authInfo != null){
        socialSignup(email: authInfo.user!.email!, fullName: authInfo.user!.displayName!, number: authInfo.user!.phoneNumber ?? '', imageLink: authInfo.user!.photoURL ?? '');
      }
    }catch(error){
      AppSnackBar.showError("Failed to login!");
      AppLoggerHelper.error(error.toString());
    }
  }

  Future<void> socialSignup({required String email, required String fullName, required String number, String? imageLink}) async{
    try{
      final requestBody = {
        "email": email,
        "fullName": fullName,
        "phone": number,
        "profileImage": imageLink,
        "socialLoginType": "GOOGLE",
        "fcmToken": ""
      };

      log(requestBody.toString());
      loadingProgressIndicator(title: "Creating...");
      final response = await NetworkCaller().postRequest(AppUrls.socialLogin, body: requestBody);

      if (response.isSuccess) {

        Get.back();

        final data = response.responseData;

        final String userId = data['data']['userId'].toString();
        final String accessToken = data['data']['accessToken'];


        await AuthService.saveId(userId);
        await AuthService.saveAccessToken(accessToken);

        AppSnackBar.showSuccess("Account Created Successfully");
        Get.offAllNamed(LandingScreen.routeName);
      } else {
        Get.back();
        errorMessage.value = response.errorMessage ?? 'Login failed. Please try again.';
      }

    }catch(error){
      AppSnackBar.showError(error.toString());
    }
  }

  var userId = "".obs;
  Future<void> signUp() async {
    // Clear previous errors
    clearErrors();

    // Basic validation
    if (nameController.text.trim().isEmpty) {
      errorMessage.value = 'Full name is required';
      return;
    }

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

    if (passwordController.text.trim().length < 6) {
      errorMessage.value = 'Password must be at least 6 characters';
      return;
    }

    try {
      isLoading.value = true;
      final requestBody = {
        "fullName": nameController.text,
        "email": emailController.text.toLowerCase(),
        "password": passwordController.text,
      };
      log('📤 Signup Request: $requestBody');

      loadingProgressIndicator(title: "Registering..");
      final response = await NetworkCaller().postRequest(AppUrls.signup, body: requestBody);

      Get.back(); // Close loading dialog

      if (response.isSuccess) {
        log('✅ Signup Response: ${response.responseData}');

        // Check if userId exists in response
        if (response.responseData['data'] != null &&
            response.responseData['data']['userId'] != null) {

          final userId = response.responseData['data']['userId'].toString();
          log('🆔 Extracted userId: $userId');

          AppSnackBar.showSuccess("Account registered successfully");

          // Navigate to OTP screen with userId
          log('🚀 Navigating to OTP screen with arguments: userId=$userId');
          Get.toNamed(
            OtpVerificationScreen.routeName,
            arguments: {
              'userId': userId,
              'email': emailController.text.trim(),
              'isSignup': true,
              'nextRoute': ChangePassSuccessScreen.routeName,
            },
          );
        } else {
          log('❌ ERROR: userId not found in response');
          log('Response data: ${response.responseData}');
          AppSnackBar.showError('Registration failed: User ID not received');
        }
      } else if (response.statusCode == 409) {
        log('⚠️ Signup conflict: ${response.errorMessage}');
        AppSnackBar.showError(response.errorMessage);
      } else {
        log('❌ Signup failed: ${response.errorMessage}');
        AppSnackBar.showError(response.errorMessage);
      }

    } catch (e) {
      Get.back(); // Close loading dialog if open
      errorMessage.value = 'Sign up failed. Please try again.';
      AppSnackBar.showError('Sign up failed. Please try again.');
      log('❌ Signup error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
