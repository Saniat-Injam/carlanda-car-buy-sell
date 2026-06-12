import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});
  static const String routeName = '/reset-password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(isBackButton: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.maxFinite,
              ),
              CustomText(
                text: "Reset your password",
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "The password must be different than before",
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                fontFamily: GoogleFonts.roboto().fontFamily,
                color: Color(0xFF62666E),
              ),
              SizedBox(height: 40.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "New password",
                    fontWeight: FontWeight.normal,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 14.sp,
                    color: Color(0xFF151B27),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.newPasswordController,
                      hintText: "•••••••••",
                      prefixIconPath: IconPath.password,
                      obscureText: controller.newPasswordObscure.value,
                      hasError: controller.errorMessage.isNotEmpty,
                      hintTextStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFFD9D9D9),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            controller.toggleNewPasswordVisibility(),
                        icon: Icon(
                          controller.newPasswordObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),

                  CustomText(
                    text: "Confirm password",
                    fontWeight: FontWeight.normal,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontSize: 14.sp,
                    color: Color(0xFF151B27),
                  ),
                  Obx(
                    () => CustomTextFormField(
                      controller: controller.confirmPasswordController,
                      hintText: "••••••••••",
                      prefixIconPath: IconPath.password,
                      obscureText: controller.confirmPasswordObscure.value,
                      hasError: controller.errorMessage.isNotEmpty,
                      hintTextStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xFFD9D9D9),
                      ),
                      onChanged: (value) => controller.clearErrors(),
                      suffixIcon: IconButton(
                        onPressed: () =>
                            controller.toggleConfirmPasswordVisibility(),
                        icon: Icon(
                          controller.confirmPasswordObscure.value
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
                              SizedBox(height: 10.h),
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
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
          child: Obx(
            () => CustomSubmitButton(
              text: "Continue",
              isLoading: controller.isLoading.value,
              onTap: () {
                controller.resetPassword();
              },
            ),
          ),
        ),
      ),
    );
  }
}
