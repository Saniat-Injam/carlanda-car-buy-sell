import 'package:carlanda_car_buy_sell/core/common/widgets/common_car_card.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/favorite/controller/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final FavoriteController controller = Get.find<FavoriteController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          CustomAppbar(isBackButton: false, title: "Favorite Car"),
          10.heightSpace(),
          Expanded(
            child:
            ListView.separated(
              shrinkWrap: false,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) =>
                  CommonCarCard(car: controller.favoriteCars[index]),
              separatorBuilder: (context, index) => 16.heightSpace(),
              itemCount: controller.favoriteCars.length,
            ),
          ),
        ],
      ),
    );
  }
}
