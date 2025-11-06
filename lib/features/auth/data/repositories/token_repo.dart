import 'package:flutter/material.dart';

class TokenRepository {
  static final ValueNotifier<String?> tokenNotifier = ValueNotifier(null);

  static String? get currentToken => tokenNotifier.value;
  static set currentToken(String? token) => tokenNotifier.value = token;

  static bool get isLoggedIn => tokenNotifier.value != null;
}
