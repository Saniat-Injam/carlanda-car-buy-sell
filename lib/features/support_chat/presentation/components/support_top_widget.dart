import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/landing/controller/landing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SupportTopWidget extends StatelessWidget {
  SupportTopWidget({super.key});
  final LandingController controller = Get.find<LandingController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0.w),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: AssetImage(ImagePath.supportProfile)),
          10.widthSpace(),
          CustomText(
            text: "Help & Support",
            color: Colors.white,
            fontSize: 16.w,
            fontWeight: FontWeight.normal,
          ),
          Spacer(),
          GestureDetector(
            onTap: () => controller.overlayController.toggle(),
            child: SvgPicture.asset(IconPath.hideIcon),
          ),
        ],
      ),
    );
  }
}
