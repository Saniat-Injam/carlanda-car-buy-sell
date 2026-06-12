import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconPath,
    required this.isCompleted,
    this.showLine = true,
  });
  final String title;
  final String subTitle;
  final String iconPath;
  final bool isCompleted;
  final bool showLine;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.13,
      width: double.maxFinite,
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: isCompleted
                    ? "#930405".toColor()
                    : "#EBA2A2".toColor(),
                radius: 25.w,
                child: SvgPicture.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    isCompleted ? Colors.white : "#151B27".toColor(),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              if (showLine) ...[
                Expanded(
                  child: Center(
                    child: VerticalDivider(
                      color: "#151B27".toColor(),
                      thickness: 4,
                    ),
                  ),
                ),
              ],
            ],
          ),
          10.widthSpace(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    Spacer(),
                    if (isCompleted) ...[
                      Icon(
                        Icons.check_circle,
                        color: "#43945B".toColor(),
                        size: 20,
                      ),
                    ] else ...[
                      Icon(
                        Icons.check_circle_outline,
                        color: "#151B27".toColor(),
                        size: 20,
                      ),
                    ],
                  ],
                ),
                4.heightSpace(),
                CustomText(
                  text: subTitle,
                  color: "#62666E".toColor(),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
