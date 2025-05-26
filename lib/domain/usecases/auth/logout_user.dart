import '../../repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;

  LogoutUser(this.repository);

  Future<void> call() async {
    // Implementation will call repository.logout()
    throw UnimplementedError('LogoutUser call method not implemented');
  }
}
