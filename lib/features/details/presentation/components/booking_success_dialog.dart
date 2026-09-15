import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/my_booking_car.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSuccessDialog extends StatelessWidget {
  const BookingSuccessDialog({super.key});

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
              text: "Booking Request Done",
              fontSize: 20.sp,
              color: "#444952".toColor(),
            ),
            10.heightSpace(),
            CustomText(
              text:
                  "Your booking request has been sent. Once the admin accepts your request, you will be able to make the payment",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
              color: "#62666E".toColor(),
            ),
            4.heightSpace(),
            // CustomText(
            //   text: "You can now make the payment",
            //   textAlign: TextAlign.center,
            //   fontWeight: FontWeight.normal,
            //   color: "#62666E".toColor(),
            // ),
            20.heightSpace(),
            CustomSubmitButton(
              text: "Done",
              onTap: () {
                Get.off(() => MyBookingCar());
              },
            ),
          ],
        ),
      ),
    );
  }
}
