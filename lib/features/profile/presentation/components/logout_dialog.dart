import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: "#FFFFFE".toColor(),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(IconPath.successTick),
            CustomText(
              text: "Log out?",
              fontSize: 24.sp,
              fontFamily: GoogleFonts.dmSans().fontFamily,
              color: "#444952".toColor(),
            ),
            CustomText(
              text: "You’ve been signed out safely. See you again soon!",
              fontSize: 14.sp,
              color: '#62666E'.toColor(),
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
            ),

            10.heightSpace(),
            Row(
              children: [
                Expanded(
                  child: CustomSubmitButton(
                    color: Colors.white,
                    textColor: "#930405".toColor(),
                    borderColor: "#930405".toColor(),
                    text: "No",
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                10.widthSpace(),
                Expanded(
                  child: CustomSubmitButton(
                    text: "Yes",
                    onTap: () {
                      Get.toNamed(AppRoute.loginScreen);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
