import 'package:carlanda_car_buy_sell/core/common/widgets/custom_appbar.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_text.dart';
import 'package:carlanda_car_buy_sell/core/common/widgets/custom_textformfield.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/personal_information_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/upload_passport_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInformationScreen extends StatelessWidget {
  PersonalInformationScreen({super.key});
  static const String routeName = "/profile/personal-information";
  final controller = Get.find<PersonalInformationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Personal Information"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightSpace(),
              CustomText(text: "Full Name", fontSize: 16.sp),
              CustomTextFormField(
                controller: controller.fullNameController,
                hintText:"Name",
                prefixIconPath: IconPath.person,
                readonly: controller.isLoading.value,
              ),
              CustomText(text: "Email", fontSize: 16.sp),
              CustomTextFormField(
                controller: controller.emailController,
                hintText: controller.initialEmail.value,
                prefixIconPath: IconPath.email,
                readonly: controller.isLoading.value,
              ),
              CustomText(text: "Phone Number", fontSize: 16.sp),
              CustomTextFormField(
                controller: controller.phoneController,
                hintText: controller.initialPhone.value,
                prefixIconPath: IconPath.phoneTec,
                readonly: controller.isLoading.value,
              ),
              CustomText(text: "Address", fontSize: 16.sp),
              CustomTextFormField(
                controller: controller.addressController,
                hintText: controller.initialAddress.value,
                prefixIconPath: IconPath.location,
                readonly: controller.isLoading.value,
              ),
              CustomText(text: "Upload Passport / ID", fontSize: 16.sp),
              10.heightSpace(),
              UploadPassportWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
          child: Obx(
            () => CustomSubmitButton(
              text: "Update",
              onTap: () {
                if (!controller.isLoading.value) {
                  controller.updatePersonalInfo();
                }
              },
              enabled: !controller.isLoading.value,
            ),
          ),
        ),
      ),
    );
  }
}
