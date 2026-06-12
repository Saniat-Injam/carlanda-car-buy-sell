import 'package:carlanda_car_buy_sell/features/notifications/controller/notification_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

class NotificationControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
      fenix: true,
    );
  }
}
