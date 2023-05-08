import 'package:dio/dio.dart';

import '../exceptions/network_exceptions.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      if (e is DioError) {
        handleError(e); // This will throw a CustomException
      } else {
        throw CustomException(message: e.toString());
      }
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      if (e is DioError) {
        handleError(e); // This will throw a CustomException
      } else {
        throw CustomException(message: e.toString());
      }
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      if (e is DioError) {
        handleError(e); // This will throw a CustomException
      } else {
        throw CustomException(message: e.toString());
      }
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      if (e is DioError) {
        handleError(e); // This will throw a CustomException
      } else {
        throw CustomException(message: e.toString());
      }
    }
  }

  void handleError(DioError error) {
    String errorDescription = "";
    int? statusCode;
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "ConnectTimeout with API server";
          break;
        case DioErrorType.other:
          errorDescription = "Connection other Error with API server";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Connection receiveTimeout with API server";
          break;
        case DioErrorType.response:
          if (error.response?.statusCode == 400) {
            errorDescription = errorByCode(error, errorDescription);
            break;
          } else if (error.response?.statusCode == 401) {
            errorDescription = errorByCode(error, errorDescription);
            break;
          } else if (error.response?.statusCode == 402) {
            errorDescription = errorByCode(error, errorDescription);
            break;
          } else if (error.response?.statusCode == 403) {
            errorDescription = errorByCode(error, errorDescription);
            break;
          } else {
            errorDescription = error.response?.statusMessage ?? '';
            break;
          }
        case DioErrorType.sendTimeout:
          errorDescription = "Connection sendTimeout with API server";
          break;
      }
      statusCode = error.response?.statusCode;
    } else {
      errorDescription = "Unexpected error occured";
    }

    throw CustomException(message: errorDescription, statusCode: statusCode);
  }

  String errorByCode(DioError error, String errorDescription) {
    try {
      Map errorData = error.response?.data;
      if (errorData['errorData'].isNotEmpty) {
        errorDescription = "${error.response?.data['errorData']['msg']}";
      } else {
        errorDescription = "${error.response?.data['errors'][0]['msg']}";
      }
    } catch (e) {
      errorDescription = error.response?.statusMessage ?? '';
    }
    return errorDescription;
  }
}
