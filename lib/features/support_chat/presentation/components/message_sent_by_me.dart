import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageSentByMe extends StatelessWidget {
  final String message;
  final String time;
  final String? image;
  final String? localImagePath;
  final String? status;

  const MessageSentByMe({
    super.key,
    required this.message,
    required this.time,
    this.image,
    this.localImagePath,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    log("showing image: $image, local: $localImagePath, status: $status");

    // Determine which image to show
    bool hasNetworkImage = image != null && image!.isNotEmpty;
    bool hasLocalImage = localImagePath != null && localImagePath!.isNotEmpty;
    bool showImage = hasNetworkImage || hasLocalImage;

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showImage) ...[],
          if (message.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              constraints: BoxConstraints(maxWidth: 260.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
              child: CustomText(
                text: message,
                color: "#171717".toColor(),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: _formatTimestamp(time),
                color: Colors.white,
                fontSize: 10,
              ),
              SizedBox(width: 4),
              // Show status icon
              _buildStatusIcon(),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (status) {
      case 'sending':
        return SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white54),
          ),
        );
      case 'sent':
        return Icon(Icons.done, size: 12, color: Colors.white54);
      case 'delivered':
        return Icon(Icons.done_all, size: 12, color: Colors.white54);
      case 'failed':
        return Icon(Icons.error_outline, size: 12, color: Colors.red);
      default:
        return SizedBox.shrink();
    }
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
