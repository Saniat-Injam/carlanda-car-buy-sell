// import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
// import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
// import 'package:flutter/material.dart';

// class BankDetailsSection extends StatelessWidget {
//   const BankDetailsSection({super.key});

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
//           _buildRow(title: "Bank Details For Payments"),
//           _buildRow(title: "Name:", value: "Listauto Angola Comercio"),
//           _buildRow(title: "Bank Name:", value: "MILLENIUM ATLANTICO"),
//           _buildRow(title: "Bank Account:", value: "\$13439833710001"),
//           8.heightSpace(),
//           _buildRow(title: "Iban:", value: "\$0055 0000 3439 8337 1015 4"),
//         ],
//       ),
//     );
//   }

//   _buildRow({required String title, String? value, bool space = true}) =>
//       Padding(
//         padding: EdgeInsets.only(bottom: space ? 8.0.h : 0),
//         child: Row(
//           children: [
//             CustomText(text: title, fontSize: 16.w),
//             // Spacer(),
//             if (value != null)
//               CustomText(
//                 text: value,
//                 fontSize: 16.w,
//                 color: "#62666E".toColor(),
//               ),
//           ],
//         ),
//       );
// }

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BankDetailsSection extends StatelessWidget {
  const BankDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          // height: 400,
          padding: EdgeInsets.fromLTRB(28.w, 44.w, 16.w, 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(IconPath.bankLogo),

                  16.widthSpace(),
                  CustomText(
                    text: "Bank Details for Payment",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              16.heightSpace(),
              _buildRow(title: "Name:", value: "LISTAUTO ANGOLA COMERCIO"),
              _buildRow(title: "Bank name:", value: "MILLENIUM ATLÂNTICO"),
              _buildRow(title: "Bank account:", value: "13439833710001"),
              _buildRow(title: "Iban:", value: "0055 0000 3439 8337 1015 4"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow({required String title, required String value}) => Padding(
    padding: EdgeInsets.only(bottom: 16.0.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w600),
        6.widthSpace(),
        Expanded(
          child: CustomText(
            text: value,
            fontSize: 14.sp,
            color: "#62666E".toColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
