import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/features/favorite/presentation/view/favorite_screen.dart';
import 'package:carlanda_car_buy_sell/features/home/presentation/view/home_screen.dart';
import 'package:carlanda_car_buy_sell/features/landing/controller/landing_controller.dart';
import 'package:carlanda_car_buy_sell/features/landing/presentation/components/custom_bottom_navbar.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/profile_screen.dart';
import 'package:carlanda_car_buy_sell/features/support_chat/presentation/view/support_chat_overlay.dart';
import 'package:carlanda_car_buy_sell/features/track_car/presentation/view/track_car_screen.dart';
import 'package:carlanda_car_buy_sell/features/view_cars/presentation/view/view_cars_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  static const String routeName = "/landing";
  final LandingController controller = Get.find<LandingController>();

  final GlobalKey _fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Obx(() {
            int currentIndex = controller.currentIndex.value;
            if (currentIndex == 0) return HomeScreen();
            if (currentIndex == 1) return ViewCarsScreen();
            if (currentIndex == 2) return TrackCarScreen();
            if (currentIndex == 3) return FavoriteScreen();
            if (currentIndex == 4) return ProfileScreen();
            return Center(child: Text("404! \nPage Not found"));
          }),
        ],
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Obx(() {
          if (controller.currentIndex.value == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.small(
                  key: _fabKey,
                  backgroundColor: Colors.black,
                  shape: CircleBorder(),
                  onPressed: () {
                    controller.overlayController.toggle();
                  },
                  child: OverlayPortal(
                    controller: controller.overlayController,
                    overlayChildBuilder: (BuildContext context) {
                      return _buildResponsiveOverlay(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset(IconPath.support),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox(key: ValueKey('fabHidden'));
          }
        }),
      ),
      bottomNavigationBar: CustomBottomNavbar(),
    );
  }

  Widget _buildResponsiveOverlay(BuildContext context) {
    return Material(
      color: Colors.black26,
      child: GestureDetector(
        onTap: () => controller.overlayController.hide(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),

            Positioned(
              bottom: 30,
              left: 16.0,
              right: 30.0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
                margin: EdgeInsets.only(bottom: _getBottomMargin(context)),
                child: GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SupportChatOverlay(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getBottomMargin(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    final fabSize = 40.0;
    final fabMargin = 16.0;
    final navBarHeight = kBottomNavigationBarHeight + bottomPadding;

    double defaultMargin = navBarHeight + fabSize + fabMargin + 8.0;

    if (keyboardHeight > 0) {
      return keyboardHeight + 20.0;
    }

    return defaultMargin;
  }
}
