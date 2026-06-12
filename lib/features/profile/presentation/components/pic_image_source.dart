import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/personal_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PicImageSource extends StatelessWidget {
  PicImageSource({super.key});
  final PersonalInformationController controller =
      Get.find<PersonalInformationController>();
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      onClosing: () {},
      builder: (context) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 8.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: CustomText(
                      text: "Add Picture",
                      fontSize: 16.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        "#FAE6E6".toColor(),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.close, color: AppColors.primary),
                  ),
                ],
              ),
              16.heightSpace(),

              // Show loading indicator when processing
              Obx(
                () => controller.isLoading.value
                    ? const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          _buildOptionButton(
                            iconPath: IconPath.camera,
                            title: "Camera",
                            onTap: () => controller.pickImage(
                              source: ImageSource.camera,
                            ),
                          ),
                          10.heightSpace(),
                          _buildOptionButton(
                            iconPath: IconPath.gallery,
                            title: "Gallery",
                            onTap: () => controller.pickImage(
                              source: ImageSource.gallery,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildOptionButton({
    required String iconPath,
    required String title,
    required Function() onTap,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(25),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: "#BABBBD".toColor()),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          10.widthSpace(),
          CustomText(
            text: title,
            color: "#4D5154".toColor(),
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    ),
  );
}
