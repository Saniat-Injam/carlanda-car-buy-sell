import 'package:carlanda_car_buy_sell/core/common/widgets/common_car_card.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/controller/view_cars_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class CarlListView extends StatelessWidget {
  CarlListView({super.key});
  final ViewCarsController controller = Get.find<ViewCarsController>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: controller.featuredCars.length,
        separatorBuilder: (context, index) => 16.heightSpace(),
        itemBuilder: (context, index) =>
            CommonCarCard(car: controller.featuredCars[index], ),
      ),
    );
  }
}
