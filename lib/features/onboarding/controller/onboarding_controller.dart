
import 'package:carlanda_car_buy_sell/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingData> onboardingPages;
  final VoidCallback? onSkip;
  final Function(bool)? onComplete;

  OnboardingController({
    required this.onboardingPages,
    this.onSkip,
    this.onComplete,
  });

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // All pages completed
      onComplete?.call(true);
    }
  }

  void skipOnboarding() {
  
    onSkip?.call();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  bool handleBackPress() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return false; // Don't exit the app
    }
    return true; // Allow system back on first page
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
