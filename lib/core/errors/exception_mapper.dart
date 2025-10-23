import 'package:dio/dio.dart';
import 'package:sairon/core/errors/exceptions.dart';

Exception mapDioError(DioException error) {
  if (error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout) {
    return NetworkException('اتصال به اینترنت برقرار نیست. لطفاً بررسی کن.');
  }

  if (error.response != null) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    final serverMessage = _extractServerMessage(data);

    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return ValidationException(serverMessage ?? 'درخواست نامعتبر بود.');
    } else if (statusCode != null && statusCode >= 500) {
      return ServerException(
        message: serverMessage ?? 'خطایی در سرور رخ داده است.',
        statusCode: statusCode,
      );
    } else {
      return UnknownException('پاسخ غیرمنتظره از سرور.');
    }
  }

  return UnknownException('خطای ناشناخته در ارتباط با سرور.');
}

String? _extractServerMessage(dynamic data) {
  if (data == null) return null;

  if (data is Map<String, dynamic>) {
    if (data['message'] != null) return data['message'];
    if (data['error'] != null) return data['error'];
    if (data['msg'] != null) return data['msg'];
  }

  return null;
}
