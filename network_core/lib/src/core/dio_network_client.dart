// In network_core/lib/src/core/dio_network_client.dart
import 'package:dio/dio.dart';
import '../config/network_config.dart'; // Will be created in the next step
import 'network_client.dart';
import 'exceptions/error_parser.dart';
import 'exceptions/network_exception.dart';
import '../utils/logger.dart'; // Will be created later

class DioNetworkClient implements NetworkClient {
  final Dio _dio;
  final NetworkConfig _networkConfig;
  final Logger _logger; // Simple logger for now

  DioNetworkClient(this._networkConfig, {Dio? dio, Logger? logger})
      : _dio = dio ?? Dio(),
        _logger = logger ?? Logger() { // Provide default logger
    // Apply base configuration from NetworkConfig
    _dio.options.baseUrl = _networkConfig.baseUrl;
    _dio.options.connectTimeout = _networkConfig.connectTimeout;
    _dio.options.receiveTimeout = _networkConfig.receiveTimeout;
    if (_networkConfig.defaultHeaders != null) {
      _dio.options.headers.addAll(_networkConfig.defaultHeaders!);
    }

    // Add interceptors if needed (e.g., for logging, auth tokens)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.log(
            LogLevel.info,
            'Request: ${options.method} ${options.uri}',
            data: options.data,
            headers: options.headers,
          );
          return handler.next(options); //continue
        },
        onResponse: (response, handler) {
          _logger.log(
            LogLevel.info,
            'Response: ${response.statusCode} ${response.requestOptions.uri}',
            data: response.data,
          );
          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          _logger.log(
            LogLevel.error,
            'Error: ${e.requestOptions.method} ${e.requestOptions.uri}',
            error: e,
            responseData: e.response?.data,
          );
          // Do not throw from here, let _handleRequest handle it
          return handler.next(e); //continue
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _handleRequest(Future<Response<dynamic>> Function() request) async {
    try {
      final response = await request();
      // Dio typically returns Map<String, dynamic> for JSON, but ensure it
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else if (response.data == null) {
        // Handle cases where response data is null (e.g. 204 No Content)
        return {};
      } else {
        // If it's not a map (e.g. a list or plain text), wrap or handle as error
        // For now, let's consider non-map responses an issue if a map is expected
        _logger.log(LogLevel.warning, "Response data is not a Map<String, dynamic>: ${response.data.runtimeType}");
        // Depending on strictness, either return as is if type is dynamic, or throw
        // For now, assuming Map<String, dynamic> is the expected successful structure
        throw UnknownNetworkException(
          message: "Unexpected response format: ${response.data.runtimeType}",
          responseData: response.data,
          statusCode: response.statusCode
        );
      }
    } on DioException catch (e) {
      throw ErrorParser.parseDioError(e);
    } catch (e) { // Catch any other unexpected errors
      _logger.log(LogLevel.error, "Unexpected error during request: ${e.toString()}");
      throw UnknownNetworkException(message: "An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _handleRequest(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        ));
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _handleRequest(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        ));
  }

  @override
  Future<Map<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _handleRequest(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        ));
  }

  @override
  Future<Map<String, dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    return _handleRequest(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        ));
  }
}
