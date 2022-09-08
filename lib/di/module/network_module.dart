import 'package:dio/dio.dart';
import 'package:shopeein/data/network/constants/endpoints.dart';
import 'package:shopeein/data/sharedpref/shared_preference_helper.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  /// Calling it multiple times will return the same instance.
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
      ..interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        // getting token
        var token = await sharedPreferenceHelper.authToken;

        if (token != null) {
          options.headers.putIfAbsent('Authorization', () => token);
        } else{
          print('Auth token is null');
        }
        return handler.next(options);
      }));
    return Dio();
  }
}
