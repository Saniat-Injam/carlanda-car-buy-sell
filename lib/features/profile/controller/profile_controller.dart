import 'package:carlanda_car_buy_sell/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  RxBool isNotificationEnable = true.obs;

  RxString profileImage = "".obs;
  final RxString croppedImage = "".obs;
  final RxBool isLoading = false.obs;

  void toggleNotification() =>
      isNotificationEnable.value = !isNotificationEnable.value;

  final ImagePicker _picker = ImagePicker();

  Future<void> selectProfileImage({required ImageSource imageSource}) async {
    try {
      isLoading.value = true;
      final XFile? pickedFile = await _picker.pickImage(
        source: imageSource,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        profileImage.value = pickedFile.path;
        Get.back();

        // Delay avoids "Reply already submitted" crash
        await Future.delayed(const Duration(milliseconds: 300));

        await _cropImage(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _cropImage(String imagePath) async {
    try {
      isLoading.value = true;

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        maxWidth: 800,
        maxHeight: 800,
        compressQuality: 85,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Profile Photo',
            toolbarColor: AppColors.primary,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            activeControlsWidgetColor: AppColors.primary,
            dimmedLayerColor: Colors.black.withValues(alpha: 0.8),
            cropFrameColor: Colors.transparent,
            cropGridColor: Colors.transparent,
            showCropGrid: false,
            lockAspectRatio: true,
            hideBottomControls: false,
            initAspectRatio: CropAspectRatioPreset.square,
            cropStyle: CropStyle.circle,
            // Helps avoid notch overlay
            statusBarColor: AppColors.primary,
          ),
          IOSUiSettings(
            title: 'Profile Photo',
            doneButtonTitle: 'Done',
            cancelButtonTitle: 'Cancel',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
            aspectRatioPickerButtonHidden: true,
            cropStyle: CropStyle.circle,
            // Notch-safe behavior
            rotateButtonsHidden: false,
          ),
        ],
      );

      if (croppedFile != null && croppedFile.path.trim().isNotEmpty) {
        croppedImage.value = croppedFile.path.trim();
      }
    } catch (e) {
      Get.snackbar("Error", "Unable to crop the image. Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void clearImage() {
    profileImage.value = "";
    croppedImage.value = "";
  }

  void retakeImage() {
    clearImage();
  }
}
