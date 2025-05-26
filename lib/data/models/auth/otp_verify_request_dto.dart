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
}
