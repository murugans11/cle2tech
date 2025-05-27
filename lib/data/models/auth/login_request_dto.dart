import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_dto.freezed.dart';
part 'login_request_dto.g.dart'; // For JsonSerializable if planning to use it

// Mapper comments:
// - Would need a mapper from AuthCredentials (domain entity) to LoginRequestDto
//   if the structure is different. AuthCredentials has separate email/phoneNumber.
//   This DTO uses a generic loginId.
// - Alternatively, AuthCredentials could be updated or a new domain entity created
//   that better matches this request structure if this DTO is strictly tied to an API.

@freezed
class LoginRequestDto with _$LoginRequestDto {
  const factory LoginRequestDto({
    required String loginId, // Can be email or phone number
    required String password,
  }) = _LoginRequestDto;

  factory LoginRequestDto.fromJson(Map<String, dynamic> json) => _$LoginRequestDtoFromJson(json);

  /*
  // Assuming import '../../../domain/entities/auth/auth_credentials.dart';

  static LoginRequestDto fromDomain(AuthCredentials credentials) {
    // This relies on AuthCredentials having accessible properties (which are part of .freezed.dart).
    // It also assumes AuthCredentials has a clear way to provide a single 'loginId'.
    // For example, if AuthCredentials has separate email and phoneNumber, logic is needed here.
    throw UnimplementedError('fromDomain() cannot be implemented without generated Freezed parts for AuthCredentials. Credentials: ${credentials}');
    // Hypothetical example (would error without .freezed parts and assuming credentials.email is the loginId):
    // return LoginRequestDto(loginId: credentials.email ?? credentials.phoneNumber ?? '', password: credentials.password ?? '');
  }
  */
}
