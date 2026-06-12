import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/landing/controller/landing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavbar extends StatelessWidget {
  CustomBottomNavbar({super.key});
  final LandingController controller = Get.find<LandingController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 8,
                //    offset: Offset(0, 4),
              ),
            ],
          ),
          child: Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,

                backgroundColor: Colors.transparent,
                elevation: 0,
                currentIndex: controller.currentIndex.value,
                onTap: (value) => controller.changeIndex(index: value),
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  fontFamily: GoogleFonts.roboto().fontFamily,
                ),
                selectedItemColor: AppColors.primary,
                unselectedItemColor: "#151B27".toColor(),
                items: [
                  _buildItem(
                    iconPath: controller.currentIndex.value == 0
                        ? controller.selectedIcon[0]
                        : controller.unselectedIcon[0],
                    title: "Home",
                  ),
                  _buildItem(
                    iconPath: controller.currentIndex.value == 1
                        ? controller.selectedIcon[1]
                        : controller.unselectedIcon[1],
                    title: "View cars",
                  ),
                  _buildItem(
                    iconPath: controller.currentIndex.value == 2
                        ? controller.selectedIcon[2]
                        : controller.unselectedIcon[2],
                    title: "Track car",
                  ),
                  _buildItem(
                    iconPath: controller.currentIndex.value == 3
                        ? controller.selectedIcon[3]
                        : controller.unselectedIcon[3],
                    title: "Favorite",
                  ),
                  _buildItem(
                    iconPath: controller.currentIndex.value == 4
                        ? controller.selectedIcon[4]
                        : controller.unselectedIcon[4],
                    title: "Profile",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildItem({
    required String iconPath,
    required String title,
  }) => BottomNavigationBarItem(
    tooltip: title,
    icon: SvgPicture.asset(iconPath, height: 25.h, width: 24.w),
    label: title,
  );
}
