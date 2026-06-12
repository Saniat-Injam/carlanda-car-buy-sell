import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/my_history_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/cancel_history_list.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/delivered_history_list.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/in_progress_histroy_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryListSection extends StatelessWidget {
  HistoryListSection({super.key});
  final MyHistoryController controller = Get.find<MyHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
          return Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (Widget child, Animation<double> animation) {
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return FadeTransition(opacity: fadeAnimation, child: child);
        },
        child: _getHistoryList(controller.selectedHistory.value),
      );
    });
  }

  Widget _getHistoryList(HistoryType type) {
    switch (type) {
      case HistoryType.inProgress:
        return InProgressHistroyList(key: ValueKey('inProgress'));
      case HistoryType.deliverd:
        return DeliveredHistoryList(key: ValueKey('delivered'));
      case HistoryType.cancel:
        return CancelHistoryList(key: ValueKey('cancel'));
    }
  }
}
