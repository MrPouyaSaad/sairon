import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

/// Central place for all validators in the app
class Validators {
  // ================== RESPONSE ==================
  /// Validate API response status code
  static void validateResponse(Response response) {
    final code = response.statusCode;
    final data = response.data;

    if (code == null || !(code == 200 || code == 201 || code == 204)) {
      final msg = _extractMessage(data, code);
      throw ServerException(message: msg, statusCode: code);
    }
  }

  /// Extract message from response data
  static String _extractMessage(dynamic data, int? code) {
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return 'Server error ($code)';
  }

  /// Handle Dio exceptions
  static Exception handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkException('Connection timeout');

      case DioExceptionType.connectionError:
        return NetworkException('No internet connection');

      case DioExceptionType.badResponse:
        if (error.response != null) {
          final msg = _extractMessage(
            error.response!.data,
            error.response!.statusCode,
          );
          return ServerException(
            message: msg,
            statusCode: error.response!.statusCode,
          );
        }
        return ServerException(message: 'Bad server response');

      default:
        return UnknownException(error.message ?? 'Unexpected Dio error');
    }
  }

  // ================== INTERNET ==================
  /// Check internet connection
  static void validateInternet(bool isConnected) {
    if (!isConnected) throw NetworkException('No internet connection');
  }

  // ================== MOBILE ==================
  /// Validate mobile number (Iran format)
  static void validateMobile(String mobile) {
    final regex = RegExp(r'^(09)[0-9]{9}$');
    if (!regex.hasMatch(mobile)) {
      throw ValidationException('Invalid mobile number');
    }
  }

  // ================== POSTAL CODE ==================
  /// Validate postal code (Iran format)
  static void validatePostalCode(String code) {
    final regex = RegExp(r'^[0-9]{10}$');
    if (!regex.hasMatch(code)) throw ValidationException('Invalid postal code');
  }

  // ================== GENERIC ==================
  /// Validate non-empty string
  static void validateNotEmpty(String value, {String? fieldName}) {
    if (value.trim().isEmpty) {
      throw ValidationException('${fieldName ?? "Field"} cannot be empty');
    }
  }

  /// Validate positive number
  static void validatePositiveNum(num value, {String? fieldName}) {
    if (value <= 0) {
      throw ValidationException('${fieldName ?? "Value"} must be positive');
    }
  }
}
