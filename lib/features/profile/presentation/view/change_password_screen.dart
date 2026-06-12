import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final controller = Get.find<ChangePasswordController>();
  static const String routeName = '/profile/change-password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Change Password"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightSpace(),
              CustomText(
                text: "Existing Password",
                fontSize: 16.sp,
                //  fontWeight: FontWeight.normal,
              ),
              CustomTextFormField(
                controller: controller.existingPassController,
                hintText: "•••••••••",
                prefixIconPath: IconPath.password,
                borderRadious: 12.w,
                obscureText: controller.existingPasswordVisibility.value,
                hasError: controller.existingPassHasError.value,
                hintTextStyle: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFD9D9D9),
                ),
                suffixIcon: IconButton(
                  onPressed: controller.toggleExistingPassVisibility,
                  icon: Icon(
                    controller.existingPasswordVisibility.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),

              CustomText(
                text: "New Password",
                fontSize: 16.sp,
                //   fontWeight: FontWeight.normal,
              ),
              CustomTextFormField(
                controller: controller.newPassController,
                hintText: "•••••••••",
                prefixIconPath: IconPath.password,
                borderRadious: 12.w,
                obscureText: controller.newPasswordVisibility.value,
                hasError: controller.newPassHasError.value,
                hintTextStyle: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFD9D9D9),
                ),
                suffixIcon: IconButton(
                  onPressed: controller.toggleNewPassVisibility,
                  icon: Icon(
                    controller.newPasswordVisibility.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),

              CustomText(
                text: "Confirm Password",
                fontSize: 16.sp,
                // fontWeight: FontWeight.normal,
              ),
              CustomTextFormField(
                controller: controller.confirmPassController,
                hintText: "•••••••••",
                prefixIconPath: IconPath.password,
                borderRadious: 12.w,
                obscureText: controller.confirmPasswordVisibility.value,
                hasError: controller.confirmPassHasError.value,
                hintTextStyle: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFFD9D9D9),
                ),
                suffixIcon: IconButton(
                  onPressed: controller.toggleConfirmPassVisibility,
                  icon: Icon(
                    controller.confirmPasswordVisibility.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
              ),

              if (controller.errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFF83737)),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: CustomText(
                          text: controller.errorMessage.value,
                          fontSize: 14.sp,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFFF83737),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
          child: CustomSubmitButton(
            text: "Change Password",
            onTap: () =>
                controller.isLoading.value ? null : controller.changePassword(),
          ),
        ),
      ),
    );
  }
}
