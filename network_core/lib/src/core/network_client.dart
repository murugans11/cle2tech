// In network_core/lib/src/core/network_client.dart
abstract class NetworkClient {
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Map<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Map<String, dynamic>> delete(
    String path, {
    dynamic data, // Some DELETE requests might have a body
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  // You might also want a more generic request method
  // Future<dynamic> request(
  //   String method,
  //   String path, {
  //   dynamic data,
  //   Map<String, dynamic>? queryParameters,
  //   Map<String, dynamic>? headers,
  // });
}
