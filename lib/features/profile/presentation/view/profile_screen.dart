import 'package:carlanda_car_buy_sell/core/utils/constants/app_sizer.dart';
import 'package:carlanda_car_buy_sell/core/utils/constants/icon_path.dart';
import 'package:carlanda_car_buy_sell/core/utils/extensions/spacer.dart';
import 'package:carlanda_car_buy_sell/features/profile/controller/profile_controller.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/logout_dialog.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/profile_header.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/components/profile_option_card.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/change_password_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/my_history_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/personal_information_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/select_language_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/terms_and_condition_screen.dart';
import 'package:carlanda_car_buy_sell/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            20.heightSpace(),
            ProfileHeader(),
            30.heightSpace(),

            ProfileOptionsCard(
              icon: IconPath.personalInfo,
              title: "Personal Information",
              onTap: () {
                Get.toNamed(PersonalInformationScreen.routeName);
              },
            ),

            ProfileOptionsCard(
              icon: IconPath.changePass,
              title: "Change Password",
              onTap: () {
                Get.toNamed(ChangePasswordScreen.routeName);
              },
            ),

            Obx(
              () => ProfileOptionsCard(
                icon: IconPath.notification,
                title: "Notification",
                onTap: () => controller.toggleNotification(),
                switchNotification: controller.isNotificationEnable.value,
              ),
            ),
            ProfileOptionsCard(
              icon: IconPath.myCar,
              title: "My booing cars",
              onTap: () {
                Get.toNamed(AppRoute.myBookingCarScreen);
              },
            ),
            ProfileOptionsCard(
              icon: IconPath.history,
              title: "My History",
              onTap: () {
                Get.toNamed(MyHistoryScreen.routeName);
              },
            ),
            ProfileOptionsCard(
              icon: IconPath.language,
              title: "Language",
              onTap: () {
                Get.toNamed(
                  SelectLanguageScreen.routeName,
                  arguments: {"isFromProfile": true},
                );
              },
            ),
            ProfileOptionsCard(
              icon: IconPath.termsAndCondition,
              title: "Terms & Condition",
              onTap: () {
                Get.toNamed(TermsAndConditionScreen.routeName);
              },
            ),

            ProfileOptionsCard(
              icon: IconPath.logout,
              title: "Log Out",
              onTap: () {
                showDialog(context: context, builder: (_) => LogoutDialog());
              },
            ),
            120.heightSpace(),
          ],
        ),
      ),
    );
  }
}
