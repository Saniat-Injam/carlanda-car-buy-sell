import 'package:carlanda_car_buy_sell/features/support_chat/controller/chat_controller.dart';
import 'package:get/get.dart';

class SupportChatControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController(), fenix: true);
  }
}
