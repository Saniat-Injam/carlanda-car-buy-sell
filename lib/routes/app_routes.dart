import 'package:carlanda_car_buy_sell/features/home/presentation/view/home_screen.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/my_booking_car.dart';
import 'package:carlanda_car_buy_sell/features/profile/presentation/view/profile_screen.dart';
import 'package:get/get.dart';

import '../features/authentication/presentation/screens/change_pass_success_screen.dart';
import '../features/authentication/presentation/screens/forget_password_screen.dart';
import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/authentication/presentation/screens/otp_verification_screen.dart';
import '../features/authentication/presentation/screens/reset_password_screen.dart';
import '../features/authentication/presentation/screens/sign_up_screen.dart';
import '../features/details/presentation/view/cost_calculation_screen.dart';
import '../features/details/presentation/view/delivery_information_screen.dart';
import '../features/landing/presentation/view/landing_screen.dart';
import '../features/notifications/presentation/view/notification_screen.dart';
import '../features/profile/presentation/view/change_password_screen.dart';
import '../features/profile/presentation/view/my_history_screen.dart';
import '../features/profile/presentation/view/personal_information_screen.dart';
import '../features/profile/presentation/view/select_language_screen.dart';
import '../features/profile/presentation/view/terms_and_condition_screen.dart';
import '../features/profile_setup/presentation/view/add_profile_picture_screen.dart';
import '../features/search/presentation/view/search_screen.dart';
import '../features/splash_screen/presentation/screens/splash_screen.dart';
import '../features/track_car/presentation/view/view_progress_screen.dart';

class AppRoute {
  static String init = "/";
  static String  costCalculationScreen= "/costCalculationScreen";
  static String  myBookingCarScreen= "/myBookingCarScreen";
  static String  profileScreen= "/profileScreen";
  static String  homeScreen= "/homeScreen";
  static String  loginScreen= "/loginScreen";
  static String  otpVerificationScreen= "/otpVerificationScreen";
  static String  addProfilePictureScreen= "/addProfilePictureScreen";
  static String  changePasswordScreen= "/changePasswordScreen";

  static List<GetPage> routes = [
    // Splash Screen
    GetPage(name: init, page: () => SplashScreen()),

    // Authentication Screens
    GetPage(name: LandingScreen.routeName, page: () => LandingScreen()),
    GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
    GetPage(name: SignUpScreen.routeName, page: () => const SignUpScreen()),
    GetPage(
      name: ForgetPasswordScreen.routeName,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: OtpVerificationScreen.routeName,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        return OtpVerificationScreen(
          email: args['email'] ?? '',
          isSignup: args['isSignup'] ?? true,
          nextRoute: args['nextRoute'] ?? '',
        );
      },
    ),
    GetPage(
      name: ResetPasswordScreen.routeName,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(
      name: ChangePassSuccessScreen.routeName,
      page: () => ChangePassSuccessScreen(
        isSignUp: Get.arguments?['isSignUp'] ?? false,
      ),
    ),

    GetPage(
      name: AddProfilePictureScreen.routeName,
      page: () => AddProfilePictureScreen(),
    ),

    GetPage(
      name: NotificationScreen.routeName,
      page: () => NotificationScreen(),
    ),

    GetPage(name: SearchScreen.routeName, page: () => SearchScreen()),

    //Profile
    GetPage(
      name: PersonalInformationScreen.routeName,
      page: () => PersonalInformationScreen(),
    ),
    GetPage(
      name: ChangePasswordScreen.routeName,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(name: MyHistoryScreen.routeName, page: () => MyHistoryScreen()),
    GetPage(
      name: TermsAndConditionScreen.routeName,
      page: () => TermsAndConditionScreen(),
    ),

    GetPage(
      name: DeliveryInformationScreen.routeName,
      page: () => DeliveryInformationScreen(),
    ),

    GetPage(
      name: ViewProgressScreen.routeName,
      page: () => ViewProgressScreen(),
    ),

    GetPage(
      name: SelectLanguageScreen.routeName,
      page: () => SelectLanguageScreen(),
    ),

    GetPage(name: costCalculationScreen, page: () => CostCalculationScreen()),
    GetPage(name: myBookingCarScreen, page: () => const MyBookingCar()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: addProfilePictureScreen, page: () => AddProfilePictureScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
  ];
}
