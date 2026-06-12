// ignore_for_file: file_names

import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/app_routes.dart';

class AuthService {
  static const String _tokenKey = 'token';
  static const String _idKey = 'id';
  static const String _refreshTokenKey = 'refreshTokenKey';
  static const String _accessTokenKey = 'accessTokenKey'; // Added access token key

  // Singleton instance for SharedPreferences
  static late SharedPreferences _preferences;

  // Private variables to hold token, refresh token, access token, and userId
  static String? _token;
  static String? _id;
  static String? _refreshToken;
  static String? _accessToken;  // Added variable for access token

  // Initialize SharedPreferences (call this during app startup)
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    // Load token, userId, and access token from SharedPreferences into private variables
    _token = _preferences.getString(_tokenKey);
    _id = _preferences.getString(_idKey);
    _refreshToken = _preferences.getString(_refreshTokenKey);
    _accessToken = _preferences.getString(_accessTokenKey);  // Load access token
  }

  // Check if a token exists in local storage
  static bool hasToken() {
    return _preferences.containsKey(_tokenKey);
  }

  // Check if refresh token exists
  static bool hasRefreshToken() {
    return _preferences.containsKey(_refreshTokenKey);
  }

  // Check if access token exists
  static bool hasAccessToken() {
    return _preferences.containsKey(_accessTokenKey);  // Check for access token
  }

  // Save both access token and refresh token together
  static Future<void> saveToken(String token) async {
    try {
      await _preferences.setString(_tokenKey, token);
      // Update private variables
      _token = token;
      log('Tokens saved successfully');
    } catch (e) {
      log('Error saving tokens: $e');
    }
  }

  // Save access token separately
  static Future<void> saveAccessToken(String accessToken) async {
    try {
      await _preferences.setString(_accessTokenKey, accessToken);
      // Update private variables
      _accessToken = accessToken;
      log('Access token saved successfully');
    } catch (e) {
      log('Error saving access token: $e');
    }
  }

  // Save refresh token separately (if needed)
  static Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _preferences.setString(_refreshTokenKey, refreshToken);
      // Update private variables
      _refreshToken = refreshToken;
      log('Refresh token saved successfully');
    } catch (e) {
      log('Error saving refresh token: $e');
    }
  }

  // Save user ID
  static Future<void> saveId(String id) async {
    try {
      await _preferences.setString(_idKey, id);
      // Update private variables
      _id = id;
      log('User ID saved successfully: $id');
    } catch (e) {
      log('Error saving user ID: $e');
    }
  }

  // Clear authentication data (for logout or clearing auth data)
  static Future<void> logoutUser() async {
    try {
      // Clear all data from SharedPreferences
      await _preferences.clear();

      // Reset private variables
      _token = null;
      _id = null;
      _refreshToken = null;
      _accessToken = null;  // Reset access token

      // Redirect to the login screen
      await goToLogin();
      log('User logged out successfully');
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  // Navigate to the login screen (e.g., after logout or token expiry)
  static Future<void> goToLogin() async {
    Get.offAllNamed(AppRoute.init); // Update with your actual login route
  }

  // Check if user is authenticated
  static bool isAuthenticated() {
    return _token != null && _token!.isNotEmpty;
  }

  // Getter for token
  static String? get token => _token;

  // Getter for userId
  static String? get id => _id;

  // Getter for refresh token
  static String? get refreshToken => _refreshToken;

  // Getter for access token
  static String? get accessToken => _accessToken;  // Getter for access token
}
