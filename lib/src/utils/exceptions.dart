/// Exceptions thrown by the Outseta API client
class ApiException implements Exception {
  /// Creates a new API exception
  ApiException(this.message, {this.statusCode});

  /// The error message
  final String message;

  /// The HTTP status code, if available
  final int? statusCode;

  @override
  String toString() => 'ApiException: $message';
}

/// Exception thrown when the request is malformed
class BadRequestException extends ApiException {
  /// Creates a new bad request exception
  BadRequestException(String message) : super(message, statusCode: 400);

  @override
  String toString() => 'BadRequestException: $message';
}

/// Exception thrown when authentication fails
class UnauthorizedException extends ApiException {
  /// Creates a new unauthorized exception
  UnauthorizedException(String message) : super(message, statusCode: 401);

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Exception thrown when the request is forbidden
class ForbiddenException extends ApiException {
  /// Creates a new forbidden exception
  ForbiddenException(String message) : super(message, statusCode: 403);

  @override
  String toString() => 'ForbiddenException: $message';
}

/// Exception thrown when the requested resource is not found
class NotFoundException extends ApiException {
  /// Creates a new not found exception
  NotFoundException(String message) : super(message, statusCode: 404);

  @override
  String toString() => 'NotFoundException: $message';
}

/// Exception thrown when the rate limit is exceeded
class RateLimitExceededException extends ApiException {
  /// Creates a new rate limit exceeded exception
  RateLimitExceededException(String message) : super(message, statusCode: 429);

  @override
  String toString() => 'RateLimitExceededException: $message';
}