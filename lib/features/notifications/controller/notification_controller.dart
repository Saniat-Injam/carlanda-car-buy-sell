import 'package:carlanda_car_buy_sell/features/notifications/data/entity/notification_entity.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NotificationController extends GetxController {
  final List<NotificationEntity> notifications = <NotificationEntity>[
    NotificationEntity(
      id: "id",
      body: "Your preview access to ‘Deep Work’ ends in 24 hours.",
      timeStamp: "1h ago",
      isReaded: false,
    ),
    NotificationEntity(
      id: "id",
      body:
          "New features and bug fixes just landed. Update now for the best experience.",
      timeStamp: "1h ago",
      isReaded: true,
    ),
    NotificationEntity(
      id: "id",
      body: "Bookmarks now sync across devices. Try it out today!",
      timeStamp: "1h ago",
      isReaded: true,
    ),
    NotificationEntity(
      id: "id",
      body:
          "Your OTP for using the Lifestyle voucher is: 653921 (valid for 10 mins).",
      timeStamp: "1h ago",
      isReaded: true,
    ),
  ];
}
