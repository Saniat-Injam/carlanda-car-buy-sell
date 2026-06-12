import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/track_car/presentation/view/view_progress_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackCarDialog extends StatelessWidget {
  const TrackCarDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Enter Code",
              fontSize: 16.sp,
              color: "#151B27".toColor(),
            ),
            10.heightSpace(),
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Enter your tracking code",
            ),
            10.heightSpace(),
            CustomSubmitButton(
              text: "Track Your Car",
              onTap: () {
                Get.back();
                Get.toNamed(ViewProgressScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
