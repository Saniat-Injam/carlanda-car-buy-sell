import 'dart:developer';
import 'dart:ui';
import 'package:carlanda_car_buy_sell/core/services/local_storage_service.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLanguage = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initializeLanguage();
  }

  /// Initialize language from saved preferences
  Future<void> _initializeLanguage() async {
    try {
      await LocalStorageService.init();
      selectedLanguage.value = LocalStorageService.language ?? 'en';
      log('Language initialized: ${selectedLanguage.value}');
    } catch (e) {
      log('Error initializing language: $e');
      // Default to English if there's an error
      selectedLanguage.value = 'en';
    }
  }

  /// Change app language
  void changeLanguage(String language) {
    try {
      selectedLanguage.value = language;
      LocalStorageService.saveLanguage(language);
      Get.updateLocale(Locale(language));
      log('Language changed to: $language');
    } catch (e) {
      log('Error changing language: $e');
    }
  }

  /// Get current language display name
  String getCurrentLanguageDisplayName() {
    switch (selectedLanguage.value) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      default:
        return 'English';
    }
  }

  /// Check if language is selected
  bool isLanguageSelected(String language) {
    return selectedLanguage.value == language;
  }
}
