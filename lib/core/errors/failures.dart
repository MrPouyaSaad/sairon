/// Base class for all domain-level failures.
/// Failures are safe representations of Exceptions for the UI layer.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Failure for server-side (HTTP) errors.
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(String message, {this.statusCode}) : super(message);
}

/// Failure for no internet or timeout.
class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'اتصال به اینترنت برقرار نیست'])
    : super(message);
}

/// Failure for invalid or malformed data.
class ValidationFailure extends Failure {
  const ValidationFailure([String message = 'داده‌های وارد شده نامعتبر است'])
    : super(message);
}

/// Failure for unknown or unexpected issues.
class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'خطای غیرمنتظره‌ای رخ داده است'])
    : super(message);
}
