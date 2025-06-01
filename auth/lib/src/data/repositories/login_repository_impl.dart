import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/remote_data_source.dart';
// UserModel is not directly returned by the repository, but used by RemoteDataSource
// import '../models/user_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final RemoteDataSource remoteDataSource;

  LoginRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    try {
      // The remoteDataSource returns a UserModel, which is a subtype of User.
      // So, it can be directly returned.
      final userModel = await remoteDataSource.login(email, password);
      return userModel;
    } catch (e) {
      // Handle exceptions from the data source, e.g., network errors, API errors
      // You might want to map these to domain-specific errors if needed
      print("LoginRepositoryImpl error: $e");
      throw Exception('Login failed. Please try again.'); // Or a custom domain error
    }
  }
}
