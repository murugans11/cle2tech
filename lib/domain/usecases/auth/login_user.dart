import '../../entities/auth/auth_credentials.dart';
import '../../entities/auth/user.dart';
import '../../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call(AuthCredentials credentials) async {
    // Implementation will call repository.login(credentials)
    // For now, placeholder:
    throw UnimplementedError('LoginUser call method not implemented');
  }
}
