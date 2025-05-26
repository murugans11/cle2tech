import '../../entities/auth/user.dart';
import '../../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<User> call(String verificationId, String otp) async {
    // Implementation will call repository.verifyOtp(verificationId, otp)
    throw UnimplementedError('VerifyOtp call method not implemented');
  }
}
