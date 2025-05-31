import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:auth/src/domain/entities/user.dart';
import 'package:auth/src/domain/repositories/login_repository.dart';
import 'package:auth/src/domain/usecases/login_usecase.dart';

// Create a mock class for LoginRepository
class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late LoginUseCase loginUseCase;
  late MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginUseCase = LoginUseCase(mockLoginRepository);
  });

  final tUser = User(id: '1', name: 'Test User', email: 'test@example.com');
  const tEmail = 'test@example.com';
  const tPassword = 'password';

  test('should get user from the repository for successful login', () async {
    // Arrange
    when(() => mockLoginRepository.login(any(), any()))
        .thenAnswer((_) async => tUser);

    // Act
    final result = await loginUseCase.call(tEmail, tPassword);

    // Assert
    expect(result, tUser);
    verify(() => mockLoginRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should throw ArgumentError for empty email', () async {
    // Act & Assert
    expect(
      () => loginUseCase.call('', tPassword),
      throwsA(isA<ArgumentError>()),
    );
    verifyZeroInteractions(mockLoginRepository);
  });

  test('should throw ArgumentError for empty password', () async {
    // Act & Assert
    expect(
      () => loginUseCase.call(tEmail, ''),
      throwsA(isA<ArgumentError>()),
    );
    verifyZeroInteractions(mockLoginRepository);
  });

  test('should throw an exception if repository throws an exception', () async {
    // Arrange
    final tException = Exception('Login failed');
    when(() => mockLoginRepository.login(any(), any())).thenThrow(tException);

    // Act & Assert
    expect(
      () => loginUseCase.call(tEmail, tPassword),
      throwsA(tException),
    );
    verify(() => mockLoginRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
