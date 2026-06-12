import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({super.key});
  static const String routeName = "/forget-password";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Center(
              child: CustomText(
                text: "Enter your email account to reset your password",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.roboto().fontFamily,
                textAlign: TextAlign.center,
                color: Color(0xFF151B27),
              ),
            ),
            SizedBox(height: 50.h),
            CustomText(
              text: "Email",
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
            ),
            Obx(() => CustomTextFormField(
              controller: controller.emailController,
              hintText: "Enter your email",
              prefixIconPath: IconPath.email,
              keyboardType: TextInputType.emailAddress,
              hasError: controller.errorMessage.isNotEmpty,
              onChanged: (value) => controller.clearErrors(),
            )),
            Obx(() => controller.errorMessage.isNotEmpty
              ? Row(
                children: [
                  Icon(Icons.error_outline, color: Color(0xFFF83737)),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: CustomText(
                      text: controller.errorMessage.value,
                      fontSize: 14.sp,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFF83737),
                    ),
                  ),
                ],
              )
              : SizedBox.shrink()
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
          child: Obx(() => CustomSubmitButton(
            text: "Continue",
            isLoading: controller.isLoading.value,
            onTap: () {
              controller.forgetPassword();
            },
          )),
        ),
      ),
    );
  }
}
