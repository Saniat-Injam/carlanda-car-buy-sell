class AppUrls {
  AppUrls._();

  static const String _baseUrl = 'http://206.162.244.142:8005/api/v1';
  static const String login = '$_baseUrl/auth/login';
  static const String signup = '$_baseUrl/auth/register';
  static const String userRegisterOtp = '$_baseUrl/auth/verify-register-otp';
  static const String verifyOtp = '$_baseUrl/auth/verify-otp';
  static const String forgotPassword = '$_baseUrl/auth/forgot-password';
  static const String resendOtp = '$_baseUrl/auth/resend-otp';
  static const String getMe = '$_baseUrl/users/me';
  static const String updatePassword = '$_baseUrl/users/update-password';
  static const String getAllCar = '$_baseUrl/cars/all-cars';
  static const String getWeeklyDeals = '$_baseUrl/cars/weekly-deals';
  static const String getMyTrackingOrders = '$_baseUrl/orders/get-my-tracking-orders';
  static const String getAllFavoriteItems = '$_baseUrl/favourite/get-all-favourite-items';
  static const String uploadProfilePicture = '$_baseUrl/users/update-profile';
  static const String resetPassword = '$_baseUrl/auth/reset-password';
  static const String socialLogin = '$_baseUrl/auth/social-login';
  static String getCarById ({required String carId})  => '$_baseUrl/cars/$carId';

}
