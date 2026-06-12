import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Details",
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),

        SizedBox(width: double.maxFinite, height: 12.h),
        CustomText(
          text:
              "Experience refined luxury and everyday performance with the 2021 Audi Q5. This premium SUV features a powerful 2.0L turbocharged engine with 261 horsepower and Audi’s signature Quattro all-wheel drive, making it ideal for both city streets and rougher terrain. The cabin offers black leather seats, a panoramic sunroof, and Audi’s Virtual Cockpit for a fully digital driving experience. With only 35,000 km, this vehicle is in excellent condition and ready for immediate export from South Korea. Perfect for drivers seeking style, safety, and smooth handling.",
          fontSize: 14.sp,
          fontWeight: FontWeight.normal,
          color: "#62666E".toColor(),
        ),
      ],
    );
  }
}
