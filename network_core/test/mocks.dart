// In network_core/test/mocks.dart
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_core/src/config/network_config.dart';
import 'package:network_core/src/utils/logger.dart'; // Assuming Logger is in src/utils

class MockDio extends Mock implements Dio {}
class MockNetworkConfig extends Mock implements NetworkConfig {}
class MockLogger extends Mock implements Logger {}

// For Dio's Response and RequestOptions if needed for detailed mocking
class MockResponse<T> extends Mock implements Response<T> {}
class MockRequestOptions extends Mock implements RequestOptions {}
// It's good practice to also mock BaseOptions if you access it directly
class MockBaseOptions extends Mock implements BaseOptions {}
