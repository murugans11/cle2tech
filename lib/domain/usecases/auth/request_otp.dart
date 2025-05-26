import '../../repositories/auth_repository.dart';

class RequestOtp {
  final AuthRepository repository;

  RequestOtp(this.repository);

  Future<String> call(String phoneNumber) async {
    // Implementation will call repository.requestOtp(phoneNumber)
    throw UnimplementedError('RequestOtp call method not implemented');
  }
}
