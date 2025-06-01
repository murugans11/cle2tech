import '../repositories/login_repository.dart';
import '../entities/user.dart';

class LoginUseCase {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<User> call(String email, String password) {
    // Basic validation can be added here if needed
    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email and password cannot be empty.');
    }
    return _repository.login(email, password);
  }
}
