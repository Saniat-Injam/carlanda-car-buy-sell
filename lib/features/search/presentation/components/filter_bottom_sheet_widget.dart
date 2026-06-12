import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/common/widgets/custom_dropdown_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_slider_widget.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/route_manager.dart';

class FilterBottomSheetWidget extends StatelessWidget {
  const FilterBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.8,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close, color: "#151B27".toColor()),
                ),
                CustomText(
                  text: "Filter",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightSpace(),
                    CustomText(text: "Brand", fontSize: 16.sp),
                    8.heightSpace(),
                    CustomDropDownButton(
                      hintText: "Select car brand",
                      items: [
                        "Land Rover",
                        "Audi",
                        "Porsche",
                        "Tesla",
                        "Ford",
                        "Other",
                      ],
                      iconPath: IconPath.cars,
                      onSelected: (onSelected) {},
                      iconColor: "#62666E".toColor(),
                    ),
                    10.heightSpace(),
                    CustomText(text: "Price", fontSize: 16.sp),
                    8.heightSpace(),
                    CustomRangeSlider(
                      min: 10000,
                      max: 100000,
                      initialStart: 10000,
                      initialEnd: 100000,
                      primaryColor: AppColors.primary,
                      rangeType: RangeType.price,
                      onChanged: (values) {
                        log("Start: ${values.start}, End: ${values.end}");
                      },
                    ),
                    10.heightSpace(),
                    CustomText(text: "Year", fontSize: 16.sp),
                    8.heightSpace(),
                    CustomRangeSlider(
                      min: 2000,
                      max: 2025,
                      initialStart: 2005,
                      initialEnd: 2025,
                      primaryColor: AppColors.primary,
                      rangeType: RangeType.year,
                      onChanged: (values) {
                        log(
                          "Year Range: ${values.start.toInt()} - ${values.end.toInt()}",
                        );
                      },
                    ),
                    10.heightSpace(),
                    CustomText(text: "Car Location", fontSize: 16.sp),
                    8.heightSpace(),
                    CustomDropDownButton(
                      hintText: "Select car Location",
                      items: ["Dubai", "South korea", "Europe"],
                      iconPath: IconPath.trackCar,
                      onSelected: (onSelected) {},
                      iconColor: "#62666E".toColor(),
                    ),

                    10.heightSpace(),
                    CustomText(text: "Fuel type", fontSize: 16.sp),
                    8.heightSpace(),
                    CustomDropDownButton(
                      hintText: "Select fuel type",
                      items: [
                        "Petrol",
                        "Diesel",
                        "Electric",
                        "Hybrid",
                        "LPG",
                        "Other",
                      ],
                      iconPath: IconPath.fuel,
                      onSelected: (onSelected) {},
                      iconColor: "#62666E".toColor(),
                      overlayPosition: OverlayPosition.top,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: CustomSubmitButton(
                      text: "Clear",
                      onTap: () {
                        Get.back();
                      },
                      color: Colors.white,
                      textColor: AppColors.primary,
                      borderColor: AppColors.primary,
                    ),
                  ),

                  16.widthSpace(),
                  Expanded(
                    child: CustomSubmitButton(text: "Apply", onTap: () {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
