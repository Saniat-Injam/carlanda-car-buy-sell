import 'dart:io';

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';

import 'package:carlanda_car_buy_sell/features/profile/controller/personal_information_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/pic_image_source.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UploadPassportWidget extends StatelessWidget {
  UploadPassportWidget({super.key});
  final PersonalInformationController controller =
      Get.find<PersonalInformationController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => showModalBottomSheet(
        context: context,
        builder: (_) => PicImageSource(),
      ),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(20),
          dashPattern: [2, 3],
          strokeWidth: 2,
          color: AppColors.primary,
        ),
        child: Obx(
          () => SizedBox(
            width: double.maxFinite,
            height: controller.uploadedPassportImage.value.isEmpty
                ? context.height * 0.13
                : context.height * 0.2,
            child: controller.uploadedPassportImage.value.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconPath.uploadImage),
                      10.heightSpace(),
                      CustomText(
                        text: "Click to upload",
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(20),
                    child: Image.file(
                      File(controller.uploadedPassportImage.value),
                      fit: BoxFit.fill,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
