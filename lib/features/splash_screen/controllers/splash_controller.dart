import 'package:carlanda_car_buy_sell/features/profile/presentation/view/select_language_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController mainAnimationController;
  late AnimationController shimmerController;

  late Animation<double> logoScaleAnimation;
  late Animation<double> logoOpacityAnimation;
  late Animation<double> shimmerAnimation;

  late Animation<double> textOpacityAnimation;
  late Animation<Offset> textSlideAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _startAnimationSequence();
  }

  void _initializeAnimations() {
    mainAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    logoScaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: mainAnimationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: mainAnimationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    shimmerAnimation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(parent: shimmerController, curve: Curves.easeInOut),
    );

    textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: mainAnimationController,
        curve: const Interval(0.4, 0.7, curve: Curves.easeIn),
      ),
    );

    textSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: mainAnimationController,
            curve: const Interval(0.4, 0.8, curve: Curves.easeOutCubic),
          ),
        );
  }

  void _startAnimationSequence() {
    mainAnimationController.forward();

    Future.delayed(const Duration(milliseconds: 400), () {
      shimmerController.repeat();
    });

    mainAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 800), () {
          navigateToHomeScreen();
        });
      }
    });
  }

  void navigateToHomeScreen() {
    // Add your navigation logic here
    Get.offAll(
      () => SelectLanguageScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    mainAnimationController.dispose();
    shimmerController.dispose();
    super.onClose();
  }
}
