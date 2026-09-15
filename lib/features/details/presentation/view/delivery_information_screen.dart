import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryInformationScreen extends StatelessWidget {
  const DeliveryInformationScreen({super.key});
  static const String routeName = "/details/delivery-information";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Delivery Information'),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.heightSpace(),
            CustomText(text: "Full Name", fontSize: 16.sp),
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Full Name",
              prefixIconPath: IconPath.person,
            ),

            CustomText(text: "Email", fontSize: 16.sp),
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "micheljhon@gmail.com",
              prefixIconPath: IconPath.email,
            ),

            CustomText(text: "Phone Number", fontSize: 16.sp),
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Enter your number",
              prefixIconPath: IconPath.phoneTec,
            ),

            CustomText(text: "Location", fontSize: 16.sp),
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Enter your location",
              prefixIconPath: IconPath.location,
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 16.w,
            vertical: 6.h,
          ),
          child: CustomSubmitButton(
            text: "Continue",
            onTap: () {
              Get.toNamed(AppRoute.costCalculationScreen);
            },
          ),
        ),
      ),
    );
  }
}
