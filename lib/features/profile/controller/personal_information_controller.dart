import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/utils/logging/logger.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/network_caller.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../home/data/model/user_profile_response.dart';

class PersonalInformationController extends GetxController {
  var isLoading = false.obs;

  var initialFullName = ''.obs;
  var initialEmail = ''.obs;
  var initialPhone = ''.obs;
  var initialAddress = ''.obs;

  var fullName = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var uploadedPassportImage = "".obs;

  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  Future<void> onInit() async {
    super.onInit();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();

    _loadInitialData();

    fullNameController.addListener(() {
      fullName.value = fullNameController.text;
    });
    emailController.addListener(() {
      email.value = emailController.text;
    });
    phoneController.addListener(() {
      phoneNumber.value = phoneController.text;
    });
    addressController.addListener(() {
      address.value = addressController.text;
    });
    await getMe();
    await updatePersonalInfo();
  }

  void _loadInitialData() {
    initialFullName.value = "John Doe";
    initialEmail.value = "john.doe@example.com";
    initialPhone.value = "0123456789";
    initialAddress.value = "123 Main St";
    fullNameController.text = initialFullName.value;
    emailController.text = initialEmail.value;
    phoneController.text = initialPhone.value;
    addressController.text = initialAddress.value;
  }

  bool hasChanges() {
    return fullName.value != initialFullName.value ||
        email.value != initialEmail.value ||
        phoneNumber.value != initialPhone.value ||
        address.value != initialAddress.value;
  }

  var fetchedInformation = UserProfileResponse();

  Future<void> getMe() async {
    try {
      final response = await NetworkCaller().getRequest(
        AppUrls.getMe,
        token: "Bearer ${AuthService.token}",
      );
      if (response.isSuccess) {
        final data = response.responseData;
        fetchedInformation = UserProfileResponse.fromJson(data);
        // log("My id is: ${AuthService.id}");
        // log("User information fetched successfully");
        // log(fetchedInformation.toString());
      } else {
        AppSnackBar.showError("Failed to fetch user information");
        log("Error status code: ${response.statusCode}");
      }
    } catch (e) {
      AppSnackBar.showError("Error fetching user information");
      log("Exception in getMe: ${e.toString()}");
    }
  }

  Future<void> updatePersonalInfo() async {
    if (!hasChanges()) {
      Get.snackbar(
        "No Changes",
        "No changes to update",
        backgroundColor: AppColors.warning,
        colorText: AppColors.textWhite,
      );
      return;
    }
    try {
      isLoading.value = true;
      await Future.delayed(Duration(seconds: 2));

      initialFullName.value = fullName.value;
      initialEmail.value = email.value;
      initialPhone.value = phoneNumber.value;
      initialAddress.value = address.value;

      Get.snackbar(
        "Success",
        "Profile updated successfully",
        backgroundColor: AppColors.success,
        colorText: AppColors.textWhite,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update: $e",
        backgroundColor: AppColors.error,
        colorText: AppColors.textWhite,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void pickImage({required ImageSource source}) async {
    try {
      Get.back();
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        uploadedPassportImage.value = pickedFile.path;
      }
    } catch (error) {
      AppLoggerHelper.error(error.toString());
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
