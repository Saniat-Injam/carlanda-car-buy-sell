// part of 'app_routes.dart';
//
// class AppRoute {
//   static String init = "/";
//
//   static List<GetPage> routes = [
//     // Splash Screen
//     GetPage(name: init, page: () => SplashScreen()),
//
//     // Authentication Screens
//     GetPage(name: LandingScreen.routeName, page: () => LandingScreen()),
//     GetPage(name: LoginScreen.routeName, page: () => const LoginScreen()),
//     GetPage(name: SignUpScreen.routeName, page: () => const SignUpScreen()),
//     GetPage(
//       name: ForgetPasswordScreen.routeName,
//       page: () => const ForgetPasswordScreen(),
//     ),
//     GetPage(
//       name: OtpVerificationScreen.routeName,
//       page: () {
//         final args = Get.arguments as Map<String, dynamic>? ?? {};
//         return OtpVerificationScreen(
//           email: args['email'] ?? '',
//           isSignup: args['isSignup'] ?? false,
//           nextRoute: args['nextRoute'] ?? '',
//         );
//       },
//     ),
//     GetPage(
//       name: ResetPasswordScreen.routeName,
//       page: () => const ResetPasswordScreen(),
//     ),
//     GetPage(
//       name: ChangePassSuccessScreen.routeName,
//       page: () => ChangePassSuccessScreen(
//         isSignUp: Get.arguments?['isSignUp'] ?? false,
//       ),
//     ),
//
//     GetPage(
//       name: AddProfilePictureScreen.routeName,
//       page: () => AddProfilePictureScreen(),
//     ),
//
//     GetPage(
//       name: NotificationScreen.routeName,
//       page: () => NotificationScreen(),
//     ),
//
//     GetPage(name: SearchScreen.routeName, page: () => SearchScreen()),
//
//     //Profile
//     GetPage(
//       name: PersonalInformationScreen.routeName,
//       page: () => PersonalInformationScreen(),
//     ),
//     GetPage(
//       name: ChangePasswordScreen.routeName,
//       page: () => ChangePasswordScreen(),
//     ),
//     GetPage(name: MyHistoryScreen.routeName, page: () => MyHistoryScreen()),
//     GetPage(
//       name: TermsAndConditionScreen.routeName,
//       page: () => TermsAndConditionScreen(),
//     ),
//
//     GetPage(
//       name: CostCalculationScreen.routeName,
//       page: () => CostCalculationScreen(),
//     ),
//
//     GetPage(
//       name: DeliveryInformationScreen.routeName,
//       page: () => DeliveryInformationScreen(),
//     ),
//
//     GetPage(
//       name: ViewProgressScreen.routeName,
//       page: () => ViewProgressScreen(),
//     ),
//
//     GetPage(
//       name: SelectLanguageScreen.routeName,
//       page: () => SelectLanguageScreen(),
//     ),
//   ];
// }
