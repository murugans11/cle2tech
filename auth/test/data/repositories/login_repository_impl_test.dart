import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auth/src/domain/entities/user.dart';
import 'package:auth/src/data/models/user_model.dart';
import 'package:auth/src/data/datasources/remote_data_source.dart';
import 'package:auth/src/data/repositories/login_repository_impl.dart';

// Create a mock class for RemoteDataSource
class MockRemoteDataSource extends Mock implements RemoteDataSource {}

void main() {
  late LoginRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = LoginRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password';
  final tUserModel = UserModel(id: '1', name: 'Test User', email: tEmail);
  // Note: The repository is expected to return a User entity, not UserModel
  final User tUser = tUserModel;

  test('should return User when the call to remote data source is successful', () async {
    // Arrange
    when(() => mockRemoteDataSource.login(any(), any()))
        .thenAnswer((_) async => tUserModel);

    // Act
    final result = await repository.login(tEmail, tPassword);

    // Assert
    expect(result, tUser); // result should be a User entity
    verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should throw an Exception when the call to remote data source is unsuccessful', () async {
    // Arrange
    final tException = Exception('Network Error');
    when(() => mockRemoteDataSource.login(any(), any())).thenThrow(tException);

    // Act & Assert
    // The repository implementation catches the original exception and throws a generic one.
    // Test for the specific exception type thrown by the repository if it's custom,
    // or a general Exception if that's what it throws.
    expect(() => repository.login(tEmail, tPassword), throwsA(isA<Exception>()));
    verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
