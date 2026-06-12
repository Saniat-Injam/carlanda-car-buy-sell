import 'package:carlanda_car_buy_sell/core/common/widgets/common_car_card.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/track_car/controllers/track_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackCarScreen extends StatelessWidget {
  TrackCarScreen({super.key});
  final TrackCarController controller = Get.find<TrackCarController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        children: [
          CustomAppbar(isBackButton: false, title: "Track Your Car"),
          10.heightSpace(),
          Expanded(
            child: ListView.separated(
              shrinkWrap: false,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) =>
                  CommonCarCard(car: controller.featuredCars[index]),
              separatorBuilder: (context, index) => 16.heightSpace(),
              itemCount: controller.featuredCars.length,
            ),
          ),
        ],
      ),
    );
  }
}
