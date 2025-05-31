// In network_core/lib/src/core/exceptions/error_parser.dart
import 'dart:io'; // For SocketException
import 'package:dio/dio.dart';
import 'network_exception.dart';

class ErrorParser {
  static NetworkException parseDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: dioError.message ?? 'Request timed out');

      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final responseData = dioError.response?.data;
        switch (statusCode) {
          case 400:
            return BadRequestException(responseData: responseData, message: _extractErrorMessage(responseData, "Bad Request"));
          case 401:
            return UnauthorizedException(responseData: responseData, message: _extractErrorMessage(responseData, "Unauthorized"));
          case 403:
            return ForbiddenException(responseData: responseData, message: _extractErrorMessage(responseData, "Forbidden"));
          case 404:
            return NotFoundException(responseData: responseData, message: _extractErrorMessage(responseData, "Not Found"));
          case 409:
            return ConflictException(responseData: responseData, message: _extractErrorMessage(responseData, "Conflict"));
          case 500:
            return InternalServerException(responseData: responseData, message: _extractErrorMessage(responseData, "Internal Server Error"));
          case 502:
            return BadGatewayException(responseData: responseData, message: _extractErrorMessage(responseData, "Bad Gateway"));
          case 503:
            return ServiceUnavailableException(responseData: responseData, message: _extractErrorMessage(responseData, "Service Unavailable"));
          default:
            return UnknownNetworkException(
              message: _extractErrorMessage(responseData, 'Unknown error occurred with status code: $statusCode'),
              statusCode: statusCode,
              responseData: responseData,
            );
        }

      case DioExceptionType.cancel:
        return NetworkException(message: 'Request was cancelled');

      case DioExceptionType.connectionError:
         return ConnectivityException(message: dioError.message ?? 'Connection error. Please check your internet connection.');

      case DioExceptionType.unknown:
      default:
        // Check if it's a connectivity issue masked as unknown
        if (dioError.error is SocketException) {
             return ConnectivityException(message: dioError.message ?? 'No Internet Connection: ${dioError.error.toString()}');
        }
        return UnknownNetworkException(message: dioError.message ?? 'An unknown network error occurred', responseData: dioError.response?.data);
    }
  }

  static String _extractErrorMessage(dynamic responseData, String defaultMessage) {
    if (responseData is Map<String, dynamic>) {
      return responseData['message'] as String? ??
             responseData['error'] as String? ??
             responseData['detail'] as String? ??
             defaultMessage;
    } else if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }
    return defaultMessage;
  }
}
