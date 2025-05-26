import '../../entities/auth/auth_credentials.dart';
import '../../entities/auth/user.dart';
import '../../repositories/auth_repository.dart';

class SignUpUser {
  final AuthRepository repository;

  SignUpUser(this.repository);

  Future<User> call(AuthCredentials credentials) async {
    // Implementation will call repository.signUp(credentials)
    throw UnimplementedError('SignUpUser call method not implemented');
  }
}
