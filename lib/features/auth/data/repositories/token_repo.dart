import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

class TokenRepository {
  static final ValueNotifier<String?> tokenNotifier = ValueNotifier(null);

  static String? get currentToken => tokenNotifier.value;
  static set currentToken(String? token) => tokenNotifier.value = token;

  static bool get isLoggedIn => tokenNotifier.value != null;

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    tokenNotifier.value = prefs.getString('token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    tokenNotifier.value = token;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    tokenNotifier.value = null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    tokenNotifier.value = null;
  }

  static Future<bool> isTokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    final expiryString = prefs.getString('token_expiry');

    if (expiryString == null) return false;

    try {
      final expiryTime = DateTime.parse(expiryString);
      return DateTime.now().isAfter(expiryTime);
    } catch (e) {
      return false;
    }
  }

  static Future<void> logoutWithConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('خروج از حساب'),
        content: const Text('آیا از خروج اطمینان دارید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('انصراف'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('خروج'),
          ),
        ],
      ),
    );

    if (result == true) {
      await logout();
    }
  }
}
