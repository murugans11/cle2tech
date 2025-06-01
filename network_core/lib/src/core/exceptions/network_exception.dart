// In network_core/lib/src/core/exceptions/network_exception.dart
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic responseData; // Could be Map<String, dynamic> or String

  NetworkException({
    required this.message,
    this.statusCode,
    this.responseData,
  });

  @override
  String toString() {
    return 'NetworkException: $message (StatusCode: $statusCode)';
  }
}

class BadRequestException extends NetworkException {
  BadRequestException({String message = "Bad Request", dynamic responseData})
      : super(message: message, statusCode: 400, responseData: responseData);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException({String message = "Unauthorized", dynamic responseData})
      : super(message: message, statusCode: 401, responseData: responseData);
}

class ForbiddenException extends NetworkException {
  ForbiddenException({String message = "Forbidden", dynamic responseData})
      : super(message: message, statusCode: 403, responseData: responseData);
}

class NotFoundException extends NetworkException {
  NotFoundException({String message = "Not Found", dynamic responseData})
      : super(message: message, statusCode: 404, responseData: responseData);
}

class ConflictException extends NetworkException {
  ConflictException({String message = "Conflict", dynamic responseData})
      : super(message: message, statusCode: 409, responseData: responseData);
}

class InternalServerException extends NetworkException {
  InternalServerException({String message = "Internal Server Error", dynamic responseData})
      : super(message: message, statusCode: 500, responseData: responseData);
}

class BadGatewayException extends NetworkException {
  BadGatewayException({String message = "Bad Gateway", dynamic responseData})
      : super(message: message, statusCode: 502, responseData: responseData);
}

class ServiceUnavailableException extends NetworkException {
  ServiceUnavailableException({String message = "Service Unavailable", dynamic responseData})
      : super(message: message, statusCode: 503, responseData: responseData);
}

class TimeoutException extends NetworkException {
  TimeoutException({String message = "Request Timed Out"})
      : super(message: message);
}

class ConnectivityException extends NetworkException {
  ConnectivityException({String message = "No Internet Connection"})
      : super(message: message);
}

class UnknownNetworkException extends NetworkException {
  UnknownNetworkException({String message = "An unknown network error occurred", dynamic responseData, int? statusCode})
      : super(message: message, responseData: responseData, statusCode: statusCode);
}
