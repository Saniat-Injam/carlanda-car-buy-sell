import 'dart:developer';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessage extends StatelessWidget {
  final String message;
  final String time;
  final String? image;

  const ReceivedMessage({
    super.key,
    required this.message,
    required this.time,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    log("showing image : $image");
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (image != null) ...[],
          if (message.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              constraints: BoxConstraints(maxWidth: 260.w),
              decoration: BoxDecoration(
                color: "#FAE6E6".toColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: CustomText(
                text: message,
                color: "#171717".toColor(),
                fontSize: 14.w,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
          CustomText(
            text: _formatTimestamp(time),
            color: Colors.white,
            fontSize: 10,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp).toLocal();
      return DateFormat('h:mm a').format(dateTime); // 2:14 PM format
    } catch (e) {
      debugPrint("Error parsing timestamp: $e");
      return timestamp; // Return original timestamp if error occurs
    }
  }
}
