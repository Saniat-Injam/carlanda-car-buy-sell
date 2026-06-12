import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/notifications/controller/notification_controller.dart';
import 'package:carlanda_car_buy_sell/features/notifications/presentation/components/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  static const String routeName = "/notifications";
  final NotificationController controller = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Notification"),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
        child: ListView.separated(
          itemBuilder: (context, index) =>
              NotificationCard(notification: controller.notifications[index]),
          separatorBuilder: (context, index) => 16.heightSpace(),
          itemCount: controller.notifications.length,
        ),
      ),
    );
  }
}
