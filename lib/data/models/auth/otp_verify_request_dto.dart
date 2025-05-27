import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_verify_request_dto.freezed.dart';
part 'otp_verify_request_dto.g.dart';

// Mapper comments:
// - Mapper from domain AuthCredentials (or specific OTP verification params) to OtpVerifyRequestDto.
// - The existing lib/models/login/OtpVerifyRequest.dart has a 'loginId' field.
//   This DTO assumes 'verificationId' (mapped from 'requestId') is sufficient.
//   If 'loginId' is also needed by the API for OTP verification, this DTO should be updated.

@freezed
class OtpVerifyRequestDto with _$OtpVerifyRequestDto {
  const factory OtpVerifyRequestDto({
    required String verificationId, // Mapped from existing 'requestId'
    required String otp,
  }) = _OtpVerifyRequestDto;

  factory OtpVerifyRequestDto.fromJson(Map<String, dynamic> json) => _$OtpVerifyRequestDtoFromJson(json);

  /*
  // Assuming import '../../../domain/entities/auth/auth_credentials.dart';

  static OtpVerifyRequestDto fromDomain(AuthCredentials credentials) {
    // This relies on AuthCredentials having accessible verificationId and otp properties.
    // If AuthCredentials doesn't directly hold these, the source of these parameters
    // for the domain use case would be passed here instead.
    throw UnimplementedError('fromDomain() cannot be implemented without generated Freezed parts for AuthCredentials. VerificationId: ${credentials.verificationId}, OTP: ${credentials.otp}');
    // Hypothetical example (would error without .freezed parts):
    // return OtpVerifyRequestDto(
    //   verificationId: credentials.verificationId ?? '',
    //   otp: credentials.otp ?? '',
    // );
  }
  */
}
