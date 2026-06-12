import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/home/controller/home_controller.dart';
import 'package:carlanda_car_buy_sell/features/notifications/presentation/view/notification_screen.dart';
import 'package:carlanda_car_buy_sell/features/search/presentation/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeTopBar extends GetView<HomeController> {
  const HomeTopBar({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.31,
      child: Stack(
        children: [
          SizedBox(
            height: context.height * 0.27,
            width: double.maxFinite,
            child: Image.asset(ImagePath.homeBg, fit: BoxFit.fill),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(WillDPictures.demoProfile),
                      ),
                      8.widthSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Hello Michel",
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                          CustomText(
                            text: "Welcome Back",
                            color: "#B6B8BC".toColor(),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          Get.toNamed(NotificationScreen.routeName);
                        },
                        icon: SvgPicture.asset(IconPath.notification),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 16.w,
            left: 16.w,
            child: CustomTextFormField(
              readonly: true,
              controller: TextEditingController(),
              onTap: () => Get.toNamed(SearchScreen.routeName),
              hintText: "Search",
              prefixIconPath: IconPath.search,
              suffixIconPath: IconPath.filter,
            ),
          ),
        ],
      ),
    );
  }
}
