import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/authentication/controllers/otp_controller.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import 'change_pass_success_screen.dart';

// class OtpVerificationScreen extends GetView<OtpController> {
//   const OtpVerificationScreen({
//     super.key,
//     required this.email,
//     required this.isSignup,
//     required this.nextRoute,
//   });
//   static const String routeName = '/verify-otp';
//   final String email;
//   final String nextRoute;
//   final bool isSignup;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppbar(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Column(
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//             CustomText(
//               text: isSignup
//                   ? "Verify your email address to get started"
//                   : "Enter verification code",
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               fontFamily: GoogleFonts.roboto().fontFamily,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 8.h, width: MediaQuery.of(context).size.width),
//             if (isSignup) ...[
//               Text.rich(
//                 TextSpan(
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: GoogleFonts.roboto().fontFamily,
//                     fontWeight: FontWeight.normal,
//                   ),
//                   children: [
//                     TextSpan(
//                       text: "We've sent a 6-digit code to ",
//                       style: TextStyle(color: Color(0xFF62666E)),
//                     ),
//                     TextSpan(
//                       text: email,
//                       style: TextStyle(color: "#930405".toColor()),
//                     ),
//                     TextSpan(
//                       text: " Enter it below to activate your account ",
//                       style: TextStyle(color: Color(0xFF62666E)),
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ] else ...[
//               CustomText(
//                 text: "We have sent a code to your",
//                 fontWeight: FontWeight.normal,
//                 fontSize: 14.sp,
//                 fontFamily: GoogleFonts.roboto().fontFamily,
//                 color: Color(0xFF62666E),
//               ),
//               CustomText(
//                 text: email,
//                 fontWeight: FontWeight.normal,
//                 fontSize: 14.sp,
//                 fontFamily: GoogleFonts.roboto().fontFamily,
//                 color: "#930405".toColor(),
//               ),
//             ],
//             SizedBox(height: 20.h),
//
//             Pinput(
//               length: 6,
//               controller: controller.pinController,
//               defaultPinTheme: PinTheme(
//                 width: 56,
//                 height: 56,
//                 textStyle: TextStyle(
//                   fontSize: 20.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey.shade400),
//                 ),
//               ),
//               focusedPinTheme: PinTheme(
//                 width: 56,
//                 height: 56,
//                 textStyle: TextStyle(
//                   fontSize: 20.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   border: Border.all(color: Colors.blue),
//                 ),
//               ),
//               submittedPinTheme: PinTheme(
//                 width: 56,
//                 height: 56,
//                 textStyle: TextStyle(
//                   fontSize: 20.sp,
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   border: Border.all(color: "#930405".toColor()),
//                 ),
//               ),
//               showCursor: true,
//               onCompleted: (pin) => controller.setOtp(pin),
//             ),
//             SizedBox(height: 16.h),
//             //Timer section
//             Obx(() {
//               final timerState = controller.timerSeconds.value;
//               final minutes = timerState ~/ 60;
//               final seconds = timerState % 60;
//               final timerText =
//                   '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//
//               return Center(
//                 child: CustomText(
//                   text: timerText,
//                   fontWeight: FontWeight.normal,
//                   color: timerState > 0 ? Colors.black : Colors.grey,
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Obx(
//                 () => CustomSubmitButton(
//                   text: "Verify",
//                   isLoading: controller.isLoading.value,
//                   onTap: () {
//                     controller.verifyOtp(nextRoute, isSignup);
//                   },
//                 ),
//               ),
//               SizedBox(height: 16.h),
//               Obx(() {
//                 final timerState = controller.timerSeconds.value;
//                 final isResendEnabled = timerState == 0;
//
//                 return Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "Didn't receive a code? ",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       TextSpan(
//                         text: "Resend code",
//                         recognizer: isResendEnabled
//                             ? (TapGestureRecognizer()
//                                 ..onTap = () {
//                                   controller.resendOtp();
//                                 })
//                             : null,
//                         style: TextStyle(
//                           color: isResendEnabled
//                               ? "#930405".toColor()
//                               : Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class OtpVerificationScreen extends GetView<OtpController> {
  const OtpVerificationScreen({
    super.key,
    this.email,
    required this.isSignup,
    required this.nextRoute,
  });
  static const String routeName = '/verify-otp';
  final String? email;
  final String nextRoute;
  final bool isSignup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            CustomText(
              text: isSignup
                  ? "Verify your email address to get started"
                  : "Enter verification code",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.roboto().fontFamily,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h, width: MediaQuery.of(context).size.width),
            if (isSignup) ...[
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: "We've sent a 6-digit code to ",
                      style: TextStyle(color: Color(0xFF62666E)),
                    ),
                    TextSpan(
                      text: email,
                      style: TextStyle(color: "#930405".toColor()),
                    ),
                    TextSpan(
                      text: " Enter it below to activate your account ",
                      style: TextStyle(color: Color(0xFF62666E)),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              CustomText(
                text: "We have sent a code to your",
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                fontFamily: GoogleFonts.roboto().fontFamily,
                color: Color(0xFF62666E),
              ),
              CustomText(
                text: email ?? controller.email.value,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                fontFamily: GoogleFonts.roboto().fontFamily,
                color: "#930405".toColor(),
              ),
            ],
            SizedBox(height: 20.h),

            Pinput(
              length: 6,
              controller: controller.pinController,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                ),
              ),
              submittedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: "#930405".toColor()),
                ),
              ),
              showCursor: true,
              onCompleted: (pin) => controller.setOtp(pin),
            ),
            SizedBox(height: 16.h),
            //Timer section
            Obx(() {
              final timerState = controller.timerSeconds.value;
              final minutes = timerState ~/ 60;
              final seconds = timerState % 60;
              final timerText =
                  '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

              return Center(
                child: CustomText(
                  text: timerText,
                  fontWeight: FontWeight.normal,
                  color: timerState > 0 ? Colors.black : Colors.grey,
                ),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                    () => CustomSubmitButton(
                  text: "Verify",
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    log("The value of is signup is: $isSignup");
                    isSignup ?
                    controller.verifyOtp(ChangePassSuccessScreen.routeName, isSignup) :
                    controller.verifyLoginOtp();
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() {
                final timerState = controller.timerSeconds.value;
                final isResendEnabled = timerState == 0;
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Didn't receive a code? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: "Resend code",
                        recognizer: isResendEnabled
                            ? (TapGestureRecognizer()
                          ..onTap = () {
                            controller.resendOtp();
                          })
                            : null,
                        style: TextStyle(
                          color: isResendEnabled
                              ? "#930405".toColor()
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
