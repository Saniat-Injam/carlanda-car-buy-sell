import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/onboarding/presentation/view/onboarding_screens.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLanguageScreen extends StatelessWidget {
  SelectLanguageScreen({super.key});
  static const String routeName = "/select-language";
  final LanguageController controller = Get.find<LanguageController>();
  final bool isFromProfile = Get.arguments?['isFromProfile'] ?? false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: context.height * 0.05, width: double.maxFinite),
              CustomText(
                text: "Choose your language",
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: "#151B27".toColor(),
              ),
              CustomText(
                text: "Select your preferred language to use \nCarLanda",
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: "#62666E".toColor(),
              ),
              SizedBox(height: 30.h),
              Obx(
                () => _buildLanguageOption(
                  context: context,
                  language: 'pt',
                  title: 'Portuguese',
                  assetPath: IconPath.flagProgugal,
                  isSelected: controller.selectedLanguage.value == 'pt',
                  onTap: () => controller.changeLanguage('pt'),
                ),
              ),
              SizedBox(height: 16.h),

              // French Option
              Obx(
                () => _buildLanguageOption(
                  context: context,
                  language: 'en',
                  title: 'English',
                  assetPath: IconPath.flagUSA,
                  isSelected: controller.selectedLanguage.value == 'en',
                  onTap: () => controller.changeLanguage('en'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomSubmitButton(
            text: isFromProfile ? "Update" : "Continue",
            onTap: () {
              if (isFromProfile) {
                Get.back();
              } else {
                Get.to(() => OnboardingScreens());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String language,
    required String title,
    required String assetPath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(35.w),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(4),
              child: Image.asset(
                assetPath,
                width: 30.w,
                height: 20.w,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: "#444952".toColor(),
                ),
              ),
            ),
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              activeColor: AppColors.primary,
              onChanged: (_) => onTap(),
            ),
          ],
        ),
      ),
    );
  }
}
