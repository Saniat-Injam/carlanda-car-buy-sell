import 'dart:io';

import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/will_d_pictures.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/profile_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile_setup/presentation/components/select_image_source_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileHeader extends StatelessWidget {
  ProfileHeader({super.key});
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.croppedImage.value.isEmpty
                            ? AssetImage(WillDPictures.demoProfile)
                                  as ImageProvider
                            : controller.croppedImage.value.contains("http")
                            ? NetworkImage(controller.croppedImage.value)
                            : FileImage(File(controller.croppedImage.value)),
                      ),
                    ),
                  ],
                ),

                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (_) =>
                          SelectImageSourceBottomSheet(controller: controller),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
