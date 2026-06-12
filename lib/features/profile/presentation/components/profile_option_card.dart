import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/gradient_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileOptionsCard extends StatelessWidget {
  const ProfileOptionsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.switchNotification = true,
  });
  final String icon;
  final String title;
  final Function() onTap;
  final bool switchNotification;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: "#FFFFFF".toColor(),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            8.widthSpace(),
            CustomText(
              text: title,
              color: "#5F5F5F".toColor(),

              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
            ),
            Spacer(),
            if (title.contains("Notification")) ...[
              GradientSwitch(
                value: switchNotification,
                onChanged: (val) {
                  onTap.call();
                },
              ),
            ] else ...[
              SvgPicture.asset(IconPath.forwardIcon),
            ],
          ],
        ),
      ),
    );
  }
}
