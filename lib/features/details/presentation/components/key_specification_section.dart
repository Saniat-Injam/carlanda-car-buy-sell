import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';

class KeySpecificationSection extends StatelessWidget {
  const KeySpecificationSection({super.key});

  Widget _buildRow(
    String leftTitle,
    String leftValue,
    String rightTitle,
    String rightValue,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: leftTitle,
                  fontSize: 12.sp,
                  color: "#62666E".toColor(),
                  fontWeight: FontWeight.normal,
                ),
                4.heightSpace(),
                CustomText(text: leftValue, fontSize: 12.sp),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: rightTitle,
                  fontSize: 12.sp,
                  color: "#62666E".toColor(),
                  fontWeight: FontWeight.normal,
                ),
                4.heightSpace(),
                CustomText(
                  text: rightValue,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: "#151B27".toColor(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Key Specification",
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),

        6.heightSpace(),
        _buildRow("Mileage", "40,000 km", "Engine Power", "250HP"),
        Divider(height: 1, color: "#CACACA".toColor()),

        _buildRow("Fuel Type", "Petrol", "Number of Cylinder", "6"),
        Divider(height: 1, color: "#CACACA".toColor()),
        _buildRow("Transmission", "Automatic", "Number of Seats", "5"),
        Divider(height: 1, color: "#CACACA".toColor()),

        _buildRow("Interior Color", "Black", "Exterior Color", "Blue"),
        4.heightSpace(),
        Divider(height: 1, color: "#CACACA".toColor()),

        _buildRow("Shipping Cost", "\$2500", "Custom Clearance Cost", "\$1000"),
        4.heightSpace(),
        Divider(height: 1, color: "#CACACA".toColor()),
      ],
    );
  }
}
