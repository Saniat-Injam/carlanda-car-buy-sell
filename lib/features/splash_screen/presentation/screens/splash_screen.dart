import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/logo_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizes.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/to_color.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      extendBody: true,
      backgroundColor: "#930405".toColor(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0.w),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            controller.mainAnimationController,
            controller.shimmerController,
          ]),
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildShimmerLogo(controller),
                  _buildSimpleText(controller),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: context.height * 0.2,
        child: Center(child: SpinKitFadingCircle(color: Colors.white)),
      ),
    );
  }

  Widget _buildShimmerLogo(SplashController controller) {
    return Transform.scale(
      scale: controller.logoScaleAnimation.value,
      child: Opacity(
        opacity: controller.logoOpacityAnimation.value,
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(
                -1.0 + controller.shimmerAnimation.value * 2,
                -1.0,
              ),
              end: Alignment(1.0 + controller.shimmerAnimation.value * 2, 1.0),
              colors: [
                Colors.white.withValues(alpha: 0.0),
                Colors.white.withValues(alpha: 0.8),
                Colors.white.withValues(alpha: 1.0),
                Colors.white.withValues(alpha: 0.8),
                Colors.white.withValues(alpha: 0.0),
              ],
              stops: [
                (controller.shimmerAnimation.value - 0.4).clamp(0.0, 1.0),
                (controller.shimmerAnimation.value - 0.2).clamp(0.0, 1.0),
                controller.shimmerAnimation.value.clamp(0.0, 1.0),
                (controller.shimmerAnimation.value + 0.2).clamp(0.0, 1.0),
                (controller.shimmerAnimation.value + 0.4).clamp(0.0, 1.0),
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: SvgPicture.asset(
            LogoPath.splashLogo,
            width: getWidth(140),
            height: getHeight(140),
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleText(SplashController controller) {
    return SlideTransition(
      position: controller.textSlideAnimation,
      child: Opacity(
        opacity: controller.textOpacityAnimation.value,
        child: Text(
          "CarLanda",
          style: GoogleFonts.poly(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw subtle floating particles
    for (int i = 0; i < 20; i++) {
      final x = (i * 47) % size.width;
      final y = (i * 73) % size.height;
      final radius = (i % 3) + 1.0;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint..color = Colors.white.withValues(alpha: 0.05 + (i % 5) * 0.01),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
