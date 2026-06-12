import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
import 'package:carlanda_car_buy_sell/features/home/presentation/components/car_category_section.dart';
import 'package:carlanda_car_buy_sell/features/home/presentation/components/featured_car_section.dart';
import 'package:carlanda_car_buy_sell/features/home/presentation/components/home_top_bar.dart';
import 'package:carlanda_car_buy_sell/features/home/presentation/components/weekly_hot_deal_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Column(
        children: [
          HomeTopBar(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WeeklyHotDealSection(),
                    22.heightSpace(),
                    CarCategorySection(),
                    16.heightSpace(),
                    FeaturedCarSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
// import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
// import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
// import 'package:carlanda_car_buy_sell/features/home/presentation/components/car_category_section.dart';
// import 'package:carlanda_car_buy_sell/features/home/presentation/components/featured_car_section.dart';
// import 'package:carlanda_car_buy_sell/features/home/presentation/components/home_top_bar.dart';
// import 'package:carlanda_car_buy_sell/features/home/presentation/components/weekly_hot_deal_section.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_utils/src/extensions/export.dart';
//
// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(250.0),
//         child: HomeTopBar(),
//       ),
//       body: SizedBox(
//         height: context.height,
//         width: context.width,
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0.w),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       WeeklyHotDealSection(),
//                       22.heightSpace(),
//                       CarCategorySection(),
//                       16.heightSpace(),
//                       FeaturedCarSection(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

