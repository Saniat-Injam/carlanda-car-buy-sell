import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/notifications/data/entity/notification_entity.dart' show NotificationEntity;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});
  final NotificationEntity notification;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: SvgPicture.asset(IconPath.notificationFill),
      ),
      title: CustomText(
        text: notification.body,
        color: notification.isReaded
            ? "#62666E".toColor()
            : "#151B27".toColor(),
        fontSize: 14.sp,
        fontWeight: notification.isReaded ? FontWeight.normal : FontWeight.w500,
      ),
      trailing: CustomText(
        text: notification.timeStamp,
        color: notification.isReaded
            ? "#62666E".toColor()
            : "#151B27".toColor(),
        fontSize: 14.sp,
        fontWeight: notification.isReaded ? FontWeight.normal : FontWeight.w500,
      ),
    );
  }
}
