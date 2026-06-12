import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/my_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHistoryTabs extends StatelessWidget {
  MyHistoryTabs({super.key});
  final MyHistoryController controller = Get.find<MyHistoryController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _buildButton(
              title: "In Progress",
              isSelected:
                  controller.selectedHistory.value == HistoryType.inProgress,
              onTap: () => controller.changeTab(type: HistoryType.inProgress),
            ),
          ),
          10.widthSpace(),
          Expanded(
            child: _buildButton(
              title: "Delivered",
              isSelected:
                  controller.selectedHistory.value == HistoryType.deliverd,
              onTap: () => controller.changeTab(type: HistoryType.deliverd),
            ),
          ),
          10.widthSpace(),
          Expanded(
            child: _buildButton(
              title: "Cancel",
              isSelected:
                  controller.selectedHistory.value == HistoryType.cancel,
              onTap: () => controller.changeTab(type: HistoryType.cancel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required bool isSelected,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: isSelected ? AppColors.primary : Colors.white,
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                FadeTransition(opacity: animation, child: child),
            child: CustomText(
              key: ValueKey<bool>(isSelected), // Ensures text fades on change
              text: title,
              fontWeight: FontWeight.normal,
              fontSize: 16.sp,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
