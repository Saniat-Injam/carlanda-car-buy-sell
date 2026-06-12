import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/controller/chat_controller.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/presentation/components/message_input_box.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/presentation/components/message_sent_by_me.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/presentation/components/recived_message.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/presentation/components/support_top_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportChatOverlay extends StatelessWidget {
  SupportChatOverlay({super.key});
  final ChatController controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: "#151B27".toColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
          bottomLeft: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SupportTopWidget(),
          Expanded(
            child: Obx(() {
              Future.delayed(Duration(milliseconds: 200), () {
                controller.viewMessage();
              });
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (controller.messages.isEmpty) {
                return Center(
                  child: CustomText(
                    text: "No conversation yet!",
                    color: Colors.white,
                  ),
                );
              }
              return ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages.reversed.toList()[index];
                  log(message.toString());

                  return message["senderId"] == ""
                      ? MessageSentByMe(
                          message: message['content'] ?? '',
                          time: message['updatedAt'] ?? '',
                          image:
                              (message["file"] != null &&
                                  message["file"].isNotEmpty)
                              ? message["file"]
                              : null,
                          localImagePath: message['localImagePath'],
                          status: message['isRead'] == true
                              ? "delivered"
                              : message['sentStatus'],
                        )
                      : ReceivedMessage(
                          message: message['content'] ?? '',
                          time: message['updatedAt'] ?? '',
                          image:
                              (message["file"] != null &&
                                  message["file"].isNotEmpty)
                              ? message["file"]
                              : null,
                        );
                },
              );
            }),
          ),

          SizedBox(height: 10),

          MessageInputBox(
            chatController: ChatController(),
            reciverId: "reciverId",
          ),
        ],
      ),
    );
  }
}
