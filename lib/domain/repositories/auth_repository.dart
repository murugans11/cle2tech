import '../entities/auth/user.dart';
import '../entities/auth/auth_credentials.dart';

abstract class AuthRepository {
  Future<User> login(AuthCredentials credentials);
  Future<User> signUp(AuthCredentials credentials); // Assuming signup returns a User object
  Future<void> logout();
  Future<User?> getCurrentUser(); // Nullable if no user is logged in
  Future<String> requestOtp(String phoneNumber); // Returns verificationId
  Future<User> verifyOtp(String verificationId, String otp);
}
