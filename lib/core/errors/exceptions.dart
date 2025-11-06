import 'package:dio/dio.dart';

/// Base class for all server/network/validation exceptions.
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

/// Exception for server-side (HTTP) errors.
class ServerException extends AppException {
  final int? statusCode;

  ServerException({required String message, this.statusCode}) : super(message);

  /// Parses Dio error response to extract message
  factory ServerException.fromDioError(DioException error) {
    try {
      final response = error.response;
      final data = response?.data;

      // Parse server message if available
      final String parsedMessage = data is Map && data['message'] != null
          ? data['message'].toString()
          : _mapStatusCodeToMessage(response?.statusCode);

      return ServerException(
        message: parsedMessage,
        statusCode: response?.statusCode,
      );
    } catch (_) {
      return ServerException(
        message: 'خطایی در ارتباط با سرور رخ داده است.',
        statusCode: 500,
      );
    }
  }

  /// Fallback messages based on HTTP status codes
  static String _mapStatusCodeToMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'درخواست شما نادرست است.';
      case 401:
        return 'دسترسی غیرمجاز. لطفاً وارد حساب شوید.';
      case 403:
        return 'شما اجازه انجام این عملیات را ندارید.';
      case 404:
        return 'موردی یافت نشد.';
      case 500:
        return 'مشکلی در سرور رخ داده است.';
      default:
        return 'خطای ناشناخته از سمت سرور.';
    }
  }

  @override
  String toString() =>
      'ServerException(status: $statusCode, message: $message)';
}

/// Exception for no internet or connection timeout.
class NetworkException extends AppException {
  NetworkException([super.message = 'اتصال به اینترنت برقرار نیست']);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception for invalid or unexpected data (client-side).
class ValidationException extends AppException {
  ValidationException([super.message = 'داده‌های وارد شده نامعتبر است']);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception for any unhandled or unknown error.
class UnknownException extends AppException {
  UnknownException([super.message = 'خطای ناشناخته‌ای رخ داده است']);

  @override
  String toString() => 'UnknownException: $message';
}
