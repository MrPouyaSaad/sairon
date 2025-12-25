/// Base class for all domain-level failures.
/// Failures are safe representations of Exceptions for the UI layer.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Failure for server-side (HTTP) errors.
class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, {this.statusCode});
}

/// Failure for no internet or timeout.
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'اتصال به اینترنت برقرار نیست']);
}

/// Failure for invalid or malformed data.
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'داده‌های وارد شده نامعتبر است']);
}

/// Failure for unknown or unexpected issues.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'خطای غیرمنتظره‌ای رخ داده است']);
}
