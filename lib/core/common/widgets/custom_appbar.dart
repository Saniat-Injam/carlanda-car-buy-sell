import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButton;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomAppbar({
    super.key,
    this.title,
    this.isBackButton = true,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? CustomText(
              text: title!,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            )
          : null,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? Colors.black,
      elevation: 0,
      leadingWidth: 80.w,
      leading: isBackButton
          ? GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: EdgeInsets.all(8.w),
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: "#FFFFFF".toColor(),
                ),
                child: Center(child: SvgPicture.asset(IconPath.arrowBack)),
              ),
            )
          : null,
      actions: actions,
      automaticallyImplyLeading: isBackButton,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
