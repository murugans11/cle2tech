import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credentials.freezed.dart';

@freezed
class AuthCredentials with _$AuthCredentials {
  const factory AuthCredentials({
    String? email,
    String? phoneNumber,
    String? password,
    String? otp,
    String? token, // For storing auth tokens
    String? verificationId, // For OTP verification processes
  }) = _AuthCredentials;
}
