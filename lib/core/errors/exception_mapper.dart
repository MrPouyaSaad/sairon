import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'exceptions.dart';
import 'failures.dart';

/// ============================================================================
/// 1. DioException → Custom Exception
/// ============================================================================

Exception mapDioError(DioException error) {
  if (error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.unknown) {
    return NetworkException(
      'اتصال به اینترنت برقرار نیست. لطفاً دوباره تلاش کنید.',
    );
  }

  if (error.response != null) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    final serverMessage = _extractServerMessage(data);

    switch (statusCode) {
      case 400:
        return ValidationException(serverMessage ?? 'درخواست نامعتبر بود.');
      case 401:
        return ServerException(
          message: serverMessage ?? 'احراز هویت انجام نشده است.',
          statusCode: 401,
        );
      case 403:
        return ServerException(
          message: serverMessage ?? 'شما مجاز به انجام این عملیات نیستید.',
          statusCode: 403,
        );
      case 404:
        return ServerException(
          message: serverMessage ?? 'مورد درخواستی یافت نشد.',
          statusCode: 404,
        );
      case 422:
        return ValidationException(
          serverMessage ?? 'داده‌های ارسال‌شده معتبر نیستند.',
        );
      default:
        if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: serverMessage ?? 'مشکلی در سرور رخ داده است.',
            statusCode: statusCode,
          );
        } else {
          return UnknownException('پاسخ غیرمنتظره از سرور دریافت شد.');
        }
    }
  }

  return UnknownException('خطای ناشناخته در ارتباط با سرور.');
}

/// Extract message from server response
String? _extractServerMessage(dynamic data) {
  if (data == null) return null;

  if (data is Map<String, dynamic>) {
    if (data['message'] != null) return data['message'].toString();
    if (data['error'] != null) return data['error'].toString();
    if (data['msg'] != null) return data['msg'].toString();
  }

  return null;
}

/// ============================================================================
/// 2. Exception → Failure
/// ============================================================================

Failure mapExceptionToFailure(Exception exception) {
  if (exception is ServerException) {
    return ServerFailure(exception.message, statusCode: exception.statusCode);
  } else if (exception is NetworkException) {
    return NetworkFailure(exception.message);
  } else if (exception is ValidationException) {
    return ValidationFailure(exception.message);
  } else {
    return UnknownFailure('خطای غیرمنتظره رخ داده است.');
  }
}

/// ============================================================================
/// 3. Helper for repository functions
/// ============================================================================
/// Wraps any async call with try-catch and returns Either <Failure, T>
/// Use this in repositories to avoid repeating try/catch logic

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on DioException catch (error) {
    final exception = mapDioError(error);

    return Left(mapExceptionToFailure(exception));
  } on Exception catch (error) {
    return Left(mapExceptionToFailure(error));
  } catch (_) {
    return Left(UnknownFailure('خطای ناشناخته در اجرای عملیات.'));
  }
}
