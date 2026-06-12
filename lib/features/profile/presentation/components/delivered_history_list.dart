import 'package:carlanda_car_buy_sell/core/common/widgets/common_history_card.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/my_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveredHistoryList extends StatelessWidget {
  DeliveredHistoryList({super.key});
  final MyHistoryController controller = Get.find<MyHistoryController>();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          CommonHistoryCard(history: controller.deliveredHistory[index]),
      separatorBuilder: (context, index) => 16.heightSpace(),
      itemCount: controller.deliveredHistory.length,
    );
  }
}
