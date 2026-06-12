import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';

class PaymentSuccessDialog extends StatelessWidget {
  const PaymentSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            20.heightSpace(),
            Image.asset(ImagePath.paymentSuccess, scale: 2.5),
            10.heightSpace(),
            CustomText(
              text: "Payment Successful",
              fontSize: 20.sp,
              color: "#444952".toColor(),
            ),
            10.heightSpace(),
            CustomText(
              text: "Payment confirmed! We've",
              textAlign: TextAlign.center,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: "#62666E".toColor(),
            ),
            4.heightSpace(),
            CustomText(
              text: "Started processing your car",
              textAlign: TextAlign.center,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: "#62666E".toColor(),
            ),
            4.heightSpace(),
            CustomText(
              text: "delivery",
              textAlign: TextAlign.center,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: "#62666E".toColor(),
            ),
          ],
        ),
      ),
    );
  }
}
