// ignore_for_file: file_names

import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  static const String _tokenKey = 'token';
  static const String _languageKey = 'language';

  // Secure storage instance
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Private variables
  static String? _token;
  static String? _language;

  /// Initialize storage (load saved values into memory)
  static Future<void> init() async {
    try {
      _token = await _secureStorage.read(key: _tokenKey);
      _language = await _secureStorage.read(key: _languageKey);
    } catch (e) {
      log("Error initializing storage: $e");
    }
  }

  /// Save token securely
  static Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
      _token = token;
    } catch (e) {
      log("Error saving token: $e");
    }
  }

  /// Get token
  static String? get token => _token;

  /// Check if token exists
  static Future<bool> hasToken() async {
    return await _secureStorage.containsKey(key: _tokenKey);
  }

  /// Remove token
  static Future<void> clearToken() async {
    try {
      await _secureStorage.delete(key: _tokenKey);
      _token = null;
    } catch (e) {
      log("Error clearing token: $e");
    }
  }

  /// Save language
  static Future<void> saveLanguage(String languageCode) async {
    try {
      await _secureStorage.write(key: _languageKey, value: languageCode);
      _language = languageCode;
    } catch (e) {
      log("Error saving language: $e");
    }
  }

  /// Get language
  static String? get language => _language;

  /// Clear all data (logout)
  static Future<void> clearAll() async {
    try {
      await _secureStorage.deleteAll();
      _token = null;
      _language = null;
      await goToLogin();
    } catch (e) {
      log("Error clearing all storage: $e");
    }
  }

  /// Navigate to login after logout
  static Future<void> goToLogin() async {
    // Example with GetX:
    // Get.offAllNamed('/login');
  }
}
