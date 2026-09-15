import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/login_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/forget_password_screen.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/widgets/custom_outline_button.dart';
import '../../../../core/common/widgets/custom_text.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});
  static const String routeName = "/login";

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
                CustomText(text: "Sign in", fontSize: 24.sp),
                SizedBox(height: 12.h),
                CustomText(
                  text: "Welcome back!  \nPlease enter your details",
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textSecondary,
                ),

                SizedBox(height: 26.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      () => Row(
                        children: [
                          if (controller.errorMessage.isNotEmpty) ...[
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Color(0xFFF83737),
                                  ),
                                  SizedBox(width: 8.w),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
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
                            ),
                          ] else ...[
                            Spacer(),
                          ],

                          InkWell(
                            onTap: () {
                              Get.toNamed(ForgetPasswordScreen.routeName);
                            },
                            child: CustomText(
                              text: "Forgot Password?",
                              fontWeight: FontWeight.normal,
                              color: "#444952".toColor(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),
                    Obx(
                      () => CustomSubmitButton(
                        text: "Sign in",
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          controller.login();
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
                      text: "Sign in with Google",
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
              TextSpan(text: "Don't have an account?"),
              TextSpan(
                text: " Sign up",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed(SignUpScreen.routeName);
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
