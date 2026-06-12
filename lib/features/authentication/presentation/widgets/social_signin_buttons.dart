import 'package:carlanda_car_buy_sell/core/common/widgets/custom_outline_button.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';

class SocialSigninButtons extends StatelessWidget {
  const SocialSigninButtons({super.key, this.isLogin = false});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomOutlineButton(
          onPressed: () {
            // Handle Google sign in/up
            // TODO: Implement Google authentication
          },
          text: isLogin ? "Sign in with Google" : "Sign up with Google",
          icon: Image.asset(IconPath.google, height: 20.h),
        ),
        // SizedBox(height: 12.h),
        // CustomOutlineButton(
        //   onPressed: () {
        //     // Handle Apple sign in/up
        //     // TODO: Implement Apple authentication
        //   },
        //   text: isLogin ? "Sign in with Apple" : "Sign up with Apple",
        //   icon: Image.asset(IconPath.apple, height: 20.h),
        // ),
      ],
    );
  }
}
