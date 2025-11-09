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
}
