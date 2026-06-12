import 'dart:developer';

import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import '../../../core/common/widgets/app_snack_bar.dart';
import '../../../core/common/widgets/loading_progress_indicator.dart';
import '../../../core/services/Auth_service.dart';
import '../../../core/utils/constants/app_urls.dart';
import '../../../core/utils/logging/logger.dart';
import '../../landing/presentation/view/landing_screen.dart';

class ProfileSetupController extends GetxController {
  final RxString selectedImage = "".obs;
  final RxString croppedImage = "".obs;
  final RxBool isLoading = false.obs;

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
        selectedImage.value = pickedFile.path;
        Get.back();
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
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
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
    selectedImage.value = "";
    croppedImage.value = "";
  }

  void retakeImage() {
    clearImage();
  }

  Future<void> requestToUploadProfilePicture() async {
    try {
      loadingProgressIndicator(title: "Uploading...");
      var request = http.MultipartRequest('PUT', Uri.parse(AppUrls.uploadProfilePicture));

      //request.fields['bodyData'] = jsonEncode(requestBody);
      await AuthService.init();
      log("The sending token is: ${AuthService.token}");
      request.headers['Authorization'] = 'Bearer ${AuthService.token}';
      request.headers['Accept'] = 'application/json';

      if(croppedImage.value.isNotEmpty){

        final mimeType = lookupMimeType(croppedImage.value) ?? "image/jpeg";
        final splitMime =  mimeType.split('/');

        request.files.add(
            await http.MultipartFile.fromPath(
                "profileImage",
                croppedImage.value,
                contentType: MediaType(splitMime[0], splitMime[1])
            )
        );
      }
      final response = await request.send();
      if(response.statusCode == 200 || response.statusCode == 201){
        Get.back();
        Get.offAndToNamed(LoginScreen.routeName);
        AppSnackBar.showSuccess("Profile picture updated successfully!!");
      }
      else{
        Get.back();
        AppSnackBar.showError("Failed to upload!!");
        log(response.statusCode.toString());
        final message = await response.stream.bytesToString();
        log(message.toString());
      }
    } catch (error) {
      Get.back();
      AppLoggerHelper.error(error.toString());
    }
  }
}
