import '../../entities/auth/user.dart';
import '../../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<User?> call() async {
    // Implementation will call repository.getCurrentUser()
    throw UnimplementedError('GetCurrentUser call method not implemented');
  }
}
