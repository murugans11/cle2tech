import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_request_dto.freezed.dart';
part 'otp_request_dto.g.dart';

// Mapper comments:
// - Mapper from domain AuthCredentials (or specific OTP request params like phoneNumber) to OtpRequestDto.
// - The existing lib/models/register/request_otp.dart has fields like toggleLoginOrNewRegister and otp,
//   and even a RequestOtpResponse, which seem out of place for a simple OTP *request* DTO.
//   This DTO focuses on just sending the phone number to request an OTP.

@freezed
class OtpRequestDto with _$OtpRequestDto {
  const factory OtpRequestDto({
    required String phoneNumber,
    // Consider if other parameters like 'type' (e.g., 'sms', 'call') are needed.
  }) = _OtpRequestDto;

  factory OtpRequestDto.fromJson(Map<String, dynamic> json) => _$OtpRequestDtoFromJson(json);

  /*
  // Assuming import '../../../domain/entities/auth/auth_credentials.dart'; // Or just take a String phoneNumber

  static OtpRequestDto fromDomain(AuthCredentials credentials) {
    // This relies on AuthCredentials having an accessible phoneNumber property.
    throw UnimplementedError('fromDomain() cannot be implemented without generated Freezed parts for AuthCredentials. Phone: ${credentials.phoneNumber}');
    // Hypothetical example (would error without .freezed parts):
    // return OtpRequestDto(phoneNumber: credentials.phoneNumber ?? '');
  }

  // Simpler alternative if only phone number string is passed from domain layer:
  // static OtpRequestDto fromPhoneNumber(String phoneNumber) {
  //   return OtpRequestDto(phoneNumber: phoneNumber);
  // }
  */
}
