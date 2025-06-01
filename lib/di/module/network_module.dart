import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:shopeein/data/network/constants/endpoints.dart';
import 'package:shopeein/data/sharedpref/shared_preference_helper.dart';

abstract class NetworkModule {

  static Dio provideDio(SharedPreferenceHelper sharedPreferenceHelper) {
    final dio = Dio();
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ))
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
          // getting token
          var token = await sharedPreferenceHelper.authToken;

          if (token != null) {
            options.headers.putIfAbsent('Authorization', () =>'Bearer $token');
          } else {
            debugPrint('Auth token is null');
          }

          logPrint('*** API Request - Start ***');

          printKV('URI', options.uri);
          printKV('METHOD', options.method);
          logPrint('HEADERS:');
          options.headers.forEach((key, v) => printKV(' - $key', v));
          logPrint('BODY:');
          printAll(options.data ?? '');

          logPrint('*** API Request - End ***');

          return handler.next(options);
        },
          onError: (DioError err, ErrorInterceptorHandler handler) {

          logPrint('*** Api Error - Start ***:');

          logPrint('URI: ${err.requestOptions.uri}');
          if (err.response != null) {
            logPrint('STATUS CODE: ${err.response?.statusCode?.toString()}');
          }
          logPrint('$err');
          if (err.response != null) {
            printKV('REDIRECT', err.response?.realUri ?? '');
            logPrint('BODY:');
            printAll(err.response?.data.toString());
          }

          logPrint('*** Api Error - End ***:');

          return handler.next(err);
        },
          onResponse: (Response response, ResponseInterceptorHandler handler) async {
          logPrint('*** Api Response - Start ***');

          printKV('URI', response.requestOptions.uri);
          printKV('STATUS CODE', response.statusCode ?? '');
          printKV('REDIRECT', response.isRedirect ?? false);
          logPrint('BODY:');
          printAll(response.data ?? '');

          logPrint('*** Api Response - End ***');

          return handler.next(response);
        }),
      );
    return dio;
  }

  static printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  static printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  static logPrint(String s) {
    debugPrint(s);
  }
}
