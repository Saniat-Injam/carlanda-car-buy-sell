import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/enums.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/details/controller/details_controller.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/view/cost_calculation_screen.dart';
import 'package:carlanda_car_buy_sell/features/details/presentation/view/delivery_information_screen.dart';
import 'package:carlanda_car_buy_sell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryOptionDialog extends StatelessWidget {
  DeliveryOptionDialog({super.key});
  final DetailsController controller = Get.find<DetailsController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: "Delivery options", fontSize: 16.sp),

              10.heightSpace(),

              _buildButton(
                value: controller.selectedOption.value == DeliveryOptions.port,
                onTap: (value) => controller.selectDeliveryOption(
                  option: DeliveryOptions.port,
                ),
                title: "Delivered to Port of Luanda",
              ),
              16.heightSpace(),
              _buildButton(
                value:
                    controller.selectedOption.value == DeliveryOptions.doorstep,
                onTap: (value) => controller.selectDeliveryOption(
                  option: DeliveryOptions.doorstep,
                ),
                title: "Delivered to My Doorstep",
              ),
              20.heightSpace(),

              CustomSubmitButton(
                text: "Continue",
                onTap: () {
                  Get.back();
                  if (controller.selectedOption.value ==
                      DeliveryOptions.doorstep) {
                    Get.toNamed(DeliveryInformationScreen.routeName);
                  } else {
                    Get.toNamed(AppRoute.costCalculationScreen);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildButton({
    required bool value,
    required Function(bool value) onTap,
    required String title,
  }) => InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () => onTap.call(value),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: "#FFFFFF".toColor(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.25),
            spreadRadius: 3,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
          Spacer(),

          Radio(
            activeColor: "#151B27".toColor(),
            value: value,
            groupValue: true,
            onChanged: (value) {
              onTap.call(value ?? false);
            },
          ),
        ],
      ),
    ),
  );
}
