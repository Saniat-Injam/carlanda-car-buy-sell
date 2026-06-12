import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/login_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile_setup/presentation/view/add_profile_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassSuccessScreen extends StatelessWidget {
  const ChangePassSuccessScreen({super.key, required this.isSignUp});
  static const String routeName = '/change-pass-success';
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: context.height * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.successBg),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            top: context.height * 0.28,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Success Icon
                  Image.asset(ImagePath.success, height: context.width * 0.3),
                  16.heightSpace(),
                  CustomText(
                    text: isSignUp
                        ? "Congratulation"
                        : "Successfully Reset your password",
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),

                  SizedBox(height: 10.h),

                  if (isSignUp) ...[
                    CustomText(
                      text:
                          "You’ve successfully created your account. Let’s get started on your Journey",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      textAlign: TextAlign.center,
                      color: "#444952".toColor(),
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ],

                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          child: CustomSubmitButton(
            text: isSignUp ? "Continue" : "Go to Sign In",
            onTap: () {
              isSignUp
                  ? Get.offAllNamed(AddProfilePictureScreen.routeName)
                  : Get.offAllNamed(LoginScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
