// import 'package:carlanda_car_buy_sell/core/common/widgets/common_car_card.dart';
// import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
// import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
// import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/get_instance.dart';
//
// class FeaturedCarSection extends StatelessWidget {
//   FeaturedCarSection({super.key});
//   final HomeController controller = Get.find<HomeController>();
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomText(
//           text: "Featured car",
//           fontWeight: FontWeight.w500,
//           fontSize: 16.sp,
//         ),
//
//         10.heightSpace(),
//         ListView.separated(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) =>
//               CommonCarCard(car: controller.featuredCars[index],),
//           separatorBuilder: (context, index) => 16.heightSpace(),
//           itemCount: 3,
//         ),
//
//         120.heightSpace(),
//       ],
//     );
//   }
// }
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/widgets/common_car_card.dart';

class FeaturedCarSection extends StatelessWidget {
  FeaturedCarSection({super.key});
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Featured car",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
        10.heightSpace(),
        if (controller.featuredCars.isEmpty) ...[
          Center(
            child: CustomText(
              text: "No cars available",
              fontSize: 14.sp,
              color: "#444952".toColor(),
            ),
          ),
        ] else ...[
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                CommonCarCard(car: controller.featuredCars[index]),
            separatorBuilder: (context, index) => 16.heightSpace(),
            itemCount: controller.featuredCars.length,
          ),
        ],

        120.heightSpace(),
      ],
    );
  }
}
