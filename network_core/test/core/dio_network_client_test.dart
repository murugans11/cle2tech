// In network_core/test/core/dio_network_client_test.dart
import 'package:dio/dio.dart';
import 'package:test/test.dart'; // Changed from flutter_test
import 'package:mocktail/mocktail.dart';
import 'package:network_core/src/core/dio_network_client.dart';
import 'package:network_core/src/config/network_config.dart';
import 'package:network_core/src/core/exceptions/network_exception.dart';
import 'package:network_core/src/utils/logger.dart';
import '../../mocks.dart';

void main() {
  late MockDio mockDio;
  late MockNetworkConfig mockNetworkConfig;
  late MockLogger mockLogger;
  late DioNetworkClient dioNetworkClient;
  late MockBaseOptions mockDioOptions; // Use the mock for BaseOptions

  setUp(() {
    mockDio = MockDio();
    mockNetworkConfig = MockNetworkConfig();
    mockLogger = MockLogger();
    mockDioOptions = MockBaseOptions(); // Initialize the mock BaseOptions

    // Setup default behaviors for NetworkConfig
    when(() => mockNetworkConfig.baseUrl).thenReturn('http://example.com');
    when(() => mockNetworkConfig.connectTimeout).thenReturn(const Duration(seconds: 5));
    when(() => mockNetworkConfig.receiveTimeout).thenReturn(const Duration(seconds: 5));
    when(() => mockNetworkConfig.defaultHeaders).thenReturn({'X-Default': 'true'});

    // Setup Dio options to use the mocked BaseOptions
    when(() => mockDio.options).thenReturn(mockDioOptions);
    // Stub the setters for options that DioNetworkClient configures
    when(() => mockDioOptions.baseUrl = any()).thenReturn(''); // Return dummy value or void if setter returns void
    when(() => mockDioOptions.connectTimeout = any()).thenReturn(Duration.zero);
    when(() => mockDioOptions.receiveTimeout = any()).thenReturn(Duration.zero);
    // Mock headers as a modifiable map
    final headersMap = <String, dynamic>{};
    when(() => mockDioOptions.headers).thenReturn(headersMap);


    when(() => mockDio.interceptors).thenReturn(Interceptors());

    dioNetworkClient = DioNetworkClient(mockNetworkConfig, dio: mockDio, logger: mockLogger);

    // Register fallback values for any() matchers if needed by mocktail
    // For RequestOptions, it's better to use a real one or a fully stubbed mock if methods are called on it.
    // For this client, RequestOptions is mostly a data carrier.
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Options()); // For Options
    // Fallback for LogLevel if not already registered by another test file (safe to do)
    registerFallbackValue(LogLevel.info);
  });

  group('DioNetworkClient Initialization', () {
    test('initializes Dio with values from NetworkConfig', () {
      // Verify that Dio's options were set via the mocked BaseOptions
      verify(() => mockDioOptions.baseUrl = 'http://example.com').called(1);
      verify(() => mockDioOptions.connectTimeout = const Duration(seconds: 5)).called(1);
      verify(() => mockDioOptions.receiveTimeout = const Duration(seconds: 5)).called(1);
      // Verify default headers were added
      expect(mockDioOptions.headers['X-Default'], 'true');
      // Verify interceptor was added
      expect(mockDio.interceptors.length, 1);
    });
  });

  group('GET requests', () {
    final tResponseData = {'id': 1, 'name': 'Test'};
    final tPath = '/test';
    late RequestOptions tRequestOptions;

    setUp((){
      tRequestOptions = RequestOptions(path: tPath);
    });

    test('should perform a GET request and return data on success', () async {
      final response = MockResponse<Map<String, dynamic>>(); // Use MockResponse
      when(() => response.data).thenReturn(tResponseData);
      when(() => response.statusCode).thenReturn(200);
      when(() => response.requestOptions).thenReturn(tRequestOptions);

      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenAnswer((_) async => response);

      final result = await dioNetworkClient.get(tPath);

      expect(result, tResponseData);
      verify(() => mockDio.get(tPath, queryParameters: null, options: any(named:'options'))).called(1);
      verify(() => mockLogger.log(LogLevel.info, contains('Request: GET'), data: null, headers: any(named: 'headers'))).called(1);
      verify(() => mockLogger.log(LogLevel.info, contains('Response: 200'), data: tResponseData)).called(1);
    });

    test('should throw NetworkException when Dio GET fails', () async {
      final dioError = DioException(
        requestOptions: tRequestOptions,
        type: DioExceptionType.badResponse,
        response: MockResponse()..statusCode=404 ..requestOptions=tRequestOptions, // chained setup
      );
      when(() => dioError.response?.statusCode).thenReturn(404); // ensure statusCode is available

      when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenThrow(dioError);

      expect(
        () => dioNetworkClient.get(tPath),
        throwsA(isA<NotFoundException>()),
      );
      verify(() => mockLogger.log(LogLevel.error, contains('Error: GET'), error: dioError, responseData: any(named: 'responseData') )).called(1);
    });

     test('should return empty map for null response data on GET', () async {
        final response = MockResponse<Map<String,dynamic>>();
        when(() => response.data).thenReturn(null); // Simulate 204 No Content
        when(() => response.statusCode).thenReturn(204);
        when(() => response.requestOptions).thenReturn(tRequestOptions);

        when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
            .thenAnswer((_) async => response);

        final result = await dioNetworkClient.get(tPath);
        expect(result, {});
    });

    test('should throw UnknownNetworkException for non-map response data on GET', () async {
        final response = MockResponse<String>(); // Simulate non-JSON object response
        when(() => response.data).thenReturn("This is not a map");
        when(() => response.statusCode).thenReturn(200);
        when(() => response.requestOptions).thenReturn(tRequestOptions);

        when(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
            .thenAnswer((_) async => response);

        expect(() => dioNetworkClient.get(tPath), throwsA(isA<UnknownNetworkException>()));
    });
  });

  group('POST requests', () {
    final tRequestData = {'name': 'Test Post'};
    final tResponseData = {'id': 2, 'name': 'Test Post'};
    final tPath = '/post_test';
    late RequestOptions tRequestOptions;

    setUp((){
      tRequestOptions = RequestOptions(path: tPath, method: 'POST');
    });

    test('should perform a POST request and return data on success', () async {
      final response = MockResponse<Map<String, dynamic>>();
      when(() => response.data).thenReturn(tResponseData);
      when(() => response.statusCode).thenReturn(201);
      when(() => response.requestOptions).thenReturn(tRequestOptions);

      when(() => mockDio.post(any(), data: any(named: 'data'), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenAnswer((_) async => response);

      final result = await dioNetworkClient.post(tPath, data: tRequestData);

      expect(result, tResponseData);
      verify(() => mockDio.post(tPath, data:tRequestData, queryParameters: null, options: any(named:'options'))).called(1);
    });

     test('should throw NetworkException when Dio POST fails', () async {
      final mockHttpResponse = MockResponse();
      when(() => mockHttpResponse.statusCode).thenReturn(500);
      when(() => mockHttpResponse.requestOptions).thenReturn(tRequestOptions);


      final dioError = DioException(
        requestOptions: tRequestOptions,
        type: DioExceptionType.badResponse,
        response: mockHttpResponse
      );

      when(() => mockDio.post(any(), data: any(named: 'data'), queryParameters: any(named: 'queryParameters'), options: any(named: 'options')))
          .thenThrow(dioError);

      expect(
        () => dioNetworkClient.post(tPath, data:tRequestData),
        throwsA(isA<InternalServerException>()),
      );
    });
  });
  // Add PUT and DELETE tests similarly...
}
