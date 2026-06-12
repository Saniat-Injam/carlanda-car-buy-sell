// import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
// import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
// import 'package:flutter/material.dart';

// class CostDetailsSection extends StatelessWidget {
//   const CostDetailsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//       ),
//       child: Column(
//         children: [
//           _buildRow(title: "Car Price", value: "\$24000"),
//           _buildRow(title: "Shipping", value: "\$2500"),
//           _buildRow(title: "Custom Clearance", value: "\$1044"),
//           Divider(color: "#CACACA".toColor()),
//           8.heightSpace(),
//           _buildRow(title: "Total", value: "\$27544", space: false),
//         ],
//       ),
//     );
//   }

//   _buildRow({
//     required String title,
//     required String value,
//     bool space = true,
//   }) => Padding(
//     padding: EdgeInsets.only(bottom: space ? 8.0.h : 0),
//     child: Row(
//       children: [
//         CustomText(text: title, fontSize: 16.w),
//         Spacer(),
//         CustomText(text: value, fontSize: 16.w),
//       ],
//     ),
//   );
// }

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';

class CostDetailsSection extends StatelessWidget {
  const CostDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Cost Summary",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        10.heightSpace(),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            children: [
              _buildRow(title: "Car Price", value: "\$24000"),
              _buildRow(title: "Shipping", value: "\$2500"),
              _buildRow(title: "Custom Clearance", value: "\$1044"),
              Divider(color: "#CACACA".toColor()),
              8.heightSpace(),
              _buildRow(title: "Total", value: "\$27544", space: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow({
    required String title,
    required String value,
    bool space = true,
  }) => Padding(
    padding: EdgeInsets.only(bottom: space ? 8.0.h : 0),
    child: Row(
      children: [
        CustomText(text: title, fontSize: 16.w),
        Spacer(),
        CustomText(text: value, fontSize: 16.w),
      ],
    ),
  );
}
