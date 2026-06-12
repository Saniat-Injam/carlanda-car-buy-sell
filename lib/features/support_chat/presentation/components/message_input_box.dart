import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessageInputBox extends StatelessWidget {
  final ChatController chatController;
  final String reciverId;
  const MessageInputBox({
    super.key,
    required this.chatController,
    required this.reciverId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  child: CustomTextFormField(
                    controller: chatController.textController,
                    hintText: 'Ask your question',
                    suffixIcon: InkWell(
                      onTap: () async {
                        final messageText = chatController.textController.text
                            .trim();

                        if (messageText.isEmpty) {
                          return;
                        }
                        chatController.selectedImage.value = "";
                        chatController.textController.clear();
                        chatController.showAttuchIcon.value = true;
                        try {
                          await chatController.sendMessage(
                            message: messageText,
                            reciverId: reciverId,
                          );
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to send message. Please try again.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      child: Container(
                        height: 30.w,
                        width: 30.w,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                        child: Center(
                          child: SvgPicture.asset(IconPath.sentButton),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
