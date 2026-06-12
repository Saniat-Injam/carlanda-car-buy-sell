import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../utils/constants/app_colors.dart';

Future<void> loadingProgressIndicator({String? title}) async {

  if (!(Get.isDialogOpen ?? false)) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.primary,
        insetPadding: EdgeInsets.symmetric(horizontal: 140.w),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 25.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SpinKitWave(
                  color: AppColors.textWhite,
                  size: 24.h,
                ),
              ),
              SizedBox(height: 16.h,),
              Center(child: CustomText(text: title ?? "Processing...", color: AppColors.textWhite, fontWeight: FontWeight.w600, textAlign: TextAlign.center,))
            ],
          ),
        ),
      ),
      barrierDismissible: false,
      useSafeArea: false,
    );
  }
  await Future.delayed(Duration(milliseconds: 1500)); //
}

Future<void> hideProgressIndicator() async {
  await Future.delayed(Duration(milliseconds: 100));
  if (Get.isDialogOpen ?? false) {
    try {
      Get.back();
    } catch (e) {
      // Already closed or error while closing
    }
  }
}

