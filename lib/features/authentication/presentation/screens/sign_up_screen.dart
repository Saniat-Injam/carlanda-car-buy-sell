import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/sign_up_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/widgets/custom_outline_button.dart';
import '../../../../core/common/widgets/custom_text.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});
  static const String routeName = "/sign-up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                  width: MediaQuery.of(context).size.width,
                ),
                CustomText(text: "Sign up", fontSize: 24.sp),
                SizedBox(height: 12.h),
                CustomText(
                  text:
                      "Create your account and start your \ncar buying journey",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textSecondary,
                ),

                SizedBox(height: 26.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Full Name",
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.nameController,
                        hintText: "Enter your full name",
                        prefixIconPath: IconPath.person,
                        hasError: controller.errorMessage.isNotEmpty,
                        onChanged: (value) => controller.clearErrors(),
                      ),
                    ),

                    CustomText(
                      text: "Email",
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.emailController,
                        hintText: "Enter your email",
                        prefixIconPath: IconPath.email,
                        keyboardType: TextInputType.emailAddress,
                        hasError: controller.errorMessage.isNotEmpty,
                        onChanged: (value) => controller.clearErrors(),
                      ),
                    ),

                    CustomText(
                      text: "Password",
                      fontWeight: FontWeight.normal,
                      fontSize: 16.sp,
                    ),
                    Obx(
                      () => CustomTextFormField(
                        controller: controller.passwordController,
                        hintText: "•••••••••",
                        prefixIconPath: IconPath.password,
                        obscureText: controller.obscureText.value,
                        hasError: controller.errorMessage.isNotEmpty,
                        onChanged: (value) => controller.clearErrors(),
                        hintTextStyle: TextStyle(
                          fontSize: 16.sp,
                          color: Color(0xFFD9D9D9),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => controller.toggleVisibility(),
                          icon: Icon(
                            controller.obscureText.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),

                    Obx(
                      () => controller.errorMessage.isNotEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Color(0xFFF83737),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: CustomText(
                                        text: controller.errorMessage.value,
                                        fontSize: 14.sp,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFF83737),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                    ),

                    SizedBox(height: 24.h),
                    Obx(
                      () => CustomSubmitButton(
                        text: "Sign up",
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          controller.signUp();
                        },
                      ),
                    ),

                    SizedBox(height: 12.h),
                    _buildOrDivider(),
                    SizedBox(height: 12.h),
                    CustomOutlineButton(
                      onPressed: () {
                        controller.fetchSocialInfo();
                      },
                      text: "Sign up with Google",
                      icon: Image.asset(IconPath.google, height: 20.h),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(text: "Already have an account?"),
              TextSpan(
                text: " Sign In",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(LoginScreen.routeName);
                  },
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildOrDivider() => Row(
    children: [
      Expanded(child: Divider()),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: CustomText(text: "or", fontWeight: FontWeight.normal),
      ),
      Expanded(child: Divider()),
    ],
  );
}
