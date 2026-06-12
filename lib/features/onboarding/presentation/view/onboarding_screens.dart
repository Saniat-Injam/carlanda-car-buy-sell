import 'dart:developer';

import 'package:carlanda_car_buy_sell/core/utils/constants/image_path.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/sign_up_screen.dart';
import 'package:carlanda_car_buy_sell/features/onboarding/data/onboarding_data.dart';
import 'package:carlanda_car_buy_sell/features/onboarding/presentation/component/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(
      backgroundImagePath: ImagePath.onboardingBg,
      pages: [
        OnboardingData(
          imagePath: ImagePath.onboarding1,
          title: 'Welcome to CarLanda',
          description:
              'Your gateway to premium vehicles, delivered from around the world ',
        ),
        OnboardingData(
          imagePath: ImagePath.onboarding2,
          title: 'Find the Perfect Car',
          description:
              'Explore a wide selection of verified vehicles  Filter by brand, specs, or location.',
        ),

        OnboardingData(
          imagePath: ImagePath.onboarding3,
          title: 'Buy, Track, Relax',
          description:
              'Use your unique tracking code to follow your car’s journey every step of the way.',
        ),
      ],
      onSkip: () {
        log("Tapped");
        Get.toNamed(SignUpScreen.routeName);
      },
      onComplete: (bool isCompleted) {
        if (isCompleted) {
          Get.to(() => SignUpScreen());
        }
      },
    );
  }
}
