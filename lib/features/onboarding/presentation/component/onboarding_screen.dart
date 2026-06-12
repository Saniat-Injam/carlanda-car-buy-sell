import 'package:carlanda_car_buy_sell/core/common/widgets/custom_submit_button.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import 'package:carlanda_car_buy_sell/features/authentication/presentation/screens/login_screen.dart';
import 'package:carlanda_car_buy_sell/features/onboarding/controller/onboarding_controller.dart';
import 'package:carlanda_car_buy_sell/features/onboarding/data/onboarding_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatelessWidget {
  final List<OnboardingData> pages;
  final VoidCallback? onSkip;
  final Function(bool)? onComplete;
  final String backgroundImagePath;

  const OnboardingScreen({
    super.key,
    required this.pages,
    this.onSkip,
    this.onComplete,
    required this.backgroundImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      OnboardingController(
        onboardingPages: pages,
        onSkip: onSkip,
        onComplete: onComplete,
      ),
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          bool shouldPop = controller.handleBackPress();
          if (shouldPop && context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(backgroundImagePath),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Stack(
                children: [
                  // Skip Button
                  PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return OnboardingPageContent(
                        data: pages[index],
                        pageIndex: index,
                        controller: controller,
                      );
                    },
                  ),

                  // Centered Page Indicator
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.35,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 50.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: controller.currentPage.value == index
                                    ? "#570303".toColor()
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      child: Obx(
                        () => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomSubmitButton(
                              text:
                                  controller.currentPage.value ==
                                      pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              onTap: controller.nextPage,
                            ),

                            if (controller.currentPage.value ==
                                pages.length - 1) ...[
                              10.heightSpace(),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Already have an account?",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: "#151B27".toColor(),
                                      ),
                                    ),

                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.to(() => LoginScreen());
                                        },
                                      text: ' Sign In',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: "#930405".toColor(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 16,
                    child: TextButton(
                      onPressed: () => controller.skipOnboarding(),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Individual Page Content Widget with Car Drift Animation
class OnboardingPageContent extends StatefulWidget {
  final OnboardingData data;
  final int pageIndex;
  final OnboardingController controller;

  const OnboardingPageContent({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.controller,
  });

  @override
  State<OnboardingPageContent> createState() => _OnboardingPageContentState();
}

class _OnboardingPageContentState extends State<OnboardingPageContent>
    with TickerProviderStateMixin {
  late AnimationController _driftController;
  late Animation<double> _driftXAnimation;
  late Animation<double> _driftYAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _driftController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _driftXAnimation = Tween<double>(begin: 120.0, end: 0.0).animate(
      CurvedAnimation(parent: _driftController, curve: Curves.easeOutCubic),
    );

    _driftYAnimation = Tween<double>(begin: -20.0, end: 0.0).animate(
      CurvedAnimation(parent: _driftController, curve: Curves.easeOutQuart),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _driftController, curve: Curves.easeOutCubic),
    );

    _rotationAnimation = Tween<double>(begin: 0.15, end: 0.0).animate(
      CurvedAnimation(parent: _driftController, curve: Curves.easeOutCubic),
    );

    _driftController.forward();
  }

  @override
  void dispose() {
    _driftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedBuilder(
              animation: _driftController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    _driftXAnimation.value,
                    _driftYAnimation.value,
                  ),
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: Image.asset(
                        widget.data.imagePath,
                        fit: BoxFit.fill,
                        height: 200.h,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Text Content Section
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                80.heightSpace(),
                Text(
                  widget.data.title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: "#151B27".toColor(),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  widget.data.description,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: "#444952".toColor(),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),

                //    const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
