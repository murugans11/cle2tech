// In network_core/lib/src/config/network_config.dart
class NetworkConfig {
  final String baseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final Map<String, String>? defaultHeaders;
  // Add any other global configurations you might need, e.g.,
  // final String apiKey;

  const NetworkConfig({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 15), // Default to 15 seconds
    this.receiveTimeout = const Duration(seconds: 15), // Default to 15 seconds
    this.defaultHeaders,
    // this.apiKey,
  });

  // Optional: A method to copy with new values if needed
  NetworkConfig copyWith({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, String>? defaultHeaders,
    // String? apiKey,
  }) {
    return NetworkConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      defaultHeaders: defaultHeaders ?? this.defaultHeaders,
      // apiKey: apiKey ?? this.apiKey,
    );
  }
}
