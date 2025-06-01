// In network_core/test/core/exceptions/error_parser_test.dart
import 'dart:io'; // For SocketException
import 'package:dio/dio.dart';
import 'package:test/test.dart'; // Changed from flutter_test
import 'package:network_core/src/core/exceptions/error_parser.dart';
import 'package:network_core/src/core/exceptions/network_exception.dart';
import '../../mocks.dart'; // Assuming mocks.dart is in test/

void main() {
  group('ErrorParser', () {
    late RequestOptions requestOptions;

    setUp(() {
      // requestOptions = MockRequestOptions(); // Using real RequestOptions for simplicity in what's being tested
      requestOptions = RequestOptions(path: 'http://example.com');
      // Ensure all necessary fields of requestOptions are non-null if accessed by ErrorParser indirectly
      // For ErrorParser, it mostly cares about the DioException and its properties.
    });

    test('parseDioError for connectionTimeout', () {
      final dioError = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionTimeout,
      );
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<TimeoutException>());
      expect(result.message, contains('timed out'));
    });

    test('parseDioError for badResponse - 400', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(400);
      when(() => response.data).thenReturn({'message': 'Invalid input'});

      final dioError = DioException(
        requestOptions: requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<BadRequestException>());
      expect(result.statusCode, 400);
      expect(result.message, 'Invalid input');
      expect(result.responseData, {'message': 'Invalid input'});
    });

    test('parseDioError for badResponse - 401', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(401);
      when(() => response.data).thenReturn(null); // Ensure data is mocked if _extractErrorMessage accesses it
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<UnauthorizedException>());
    });

    test('parseDioError for badResponse - 403', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(403);
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<ForbiddenException>());
    });

    test('parseDioError for badResponse - 404', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(404);
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<NotFoundException>());
    });

    test('parseDioError for badResponse - 409', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(409);
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<ConflictException>());
    });

    test('parseDioError for badResponse - 500', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(500);
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<InternalServerException>());
    });

    test('parseDioError for badResponse - 502', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(502);
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<BadGatewayException>());
    });

    test('parseDioError for badResponse - 503', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(503);
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<ServiceUnavailableException>());
    });

    test('parseDioError for badResponse - unknown status code', () {
      final response = MockResponse<dynamic>();
      when(() => response.statusCode).thenReturn(418); // I'm a teapot
      when(() => response.data).thenReturn(null);
      final dioError = DioException(requestOptions: requestOptions, response: response, type: DioExceptionType.badResponse);
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<UnknownNetworkException>());
      expect(result.statusCode, 418);
    });

    test('parseDioError for connectionError', () {
      final dioError = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.connectionError,
        message: 'Failed host lookup'
      );
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<ConnectivityException>());
      expect(result.message, contains('Failed host lookup'));
    });

    test('parseDioError for unknown error with SocketException', () {
      final socketException = SocketException("OS Error: Connection refused");
      final dioError = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.unknown,
        error: socketException,
      );
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<ConnectivityException>());
      expect(result.message, contains('No Internet Connection'));
    });

    test('parseDioError for unknown error without SocketException', () {
      final dioError = DioException(
        requestOptions: requestOptions,
        type: DioExceptionType.unknown,
        error: "Some other error",
      );
      final result = ErrorParser.parseDioError(dioError);
      expect(result, isA<UnknownNetworkException>());
    });

  });
}
