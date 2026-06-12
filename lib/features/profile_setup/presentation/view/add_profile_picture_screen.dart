import 'dart:io';

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/landing/presentation/view/landing_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile_setup/controller/profile_setup_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile_setup/presentation/components/select_image_source_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProfilePictureScreen extends StatelessWidget {
  AddProfilePictureScreen({super.key});
  static const String routeName = '/add-profile-picture';
  final ProfileSetupController controller = Get.find<ProfileSetupController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed(LandingScreen.routeName);
            },
            child: CustomText(
              text: "Skip",
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: "#151B27".toColor(),
            ),
          ),
          10.widthSpace(),
        ],
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              50.heightSpace(),
              CustomText(
                text: "Add your profile picture",
                fontSize: 24.sp,
                color: "#212529".toColor(),
              ),
              10.heightSpace(),
              CustomText(
                text:
                    "Upload a photo so we can \nrecognize you during delivery.",
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: "#4D5154".toColor(),
              ),
              50.heightSpace(),
              context.width.widthSpace(),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (_) =>
                      SelectImageSourceBottomSheet(controller: controller),
                ),
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Obx(
                    () => CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60.h,
                      foregroundImage: controller.croppedImage.value.isNotEmpty
                          ? FileImage(File(controller.croppedImage.value))
                          : AssetImage(ImagePath.profile),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(
            () => CustomSubmitButton(
              text: controller.croppedImage.value.isNotEmpty
                  ? "Continue"
                  : "Add Picture",
              onTap: () {
                controller.croppedImage.value.isNotEmpty
                    ? controller.requestToUploadProfilePicture()
                    : showModalBottomSheet(
                        context: context,
                        builder: (_) => SelectImageSourceBottomSheet(
                          controller: controller,
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
