import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request_dto.freezed.dart';
part 'signup_request_dto.g.dart';

// Mapper comments:
// - Mapper from AuthCredentials or a dedicated domain SignUpParameters entity to SignUpRequestDto.
// - The existing RegistrationRequest model has more fields like gender, otp, requestId.
//   This DTO is a simplified version based on common signup patterns.
//   If those fields are always required, this DTO or the domain entity driving it would need adjustment.
// - Mapping from domain User (if it holds signup info) to this DTO:
//   User.name -> SignUpRequestDto.name (potentially splitting if domain User has firstName/lastName)
//   User.email -> SignUpRequestDto.email
//   User.phoneNumber -> SignUpRequestDto.phoneNumber
//   AuthCredentials.password -> SignUpRequestDto.password

@freezed
class SignUpRequestDto with _$SignUpRequestDto {
  const factory SignUpRequestDto({
    required String name, // Combined from firstName and lastName
    required String email,
    required String password,
    String? phoneNumber,
  }) = _SignUpRequestDto;

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) => _$SignUpRequestDtoFromJson(json);

  /*
  // Assuming import '../../../domain/entities/auth/auth_credentials.dart';
  // Or a more specific domain entity if User/AuthCredentials don't directly map, e.g., SignUpParams.
  // For this example, let's assume we map from a combination of User and AuthCredentials.

  static SignUpRequestDto fromDomain(AuthCredentials credentials, {String? name}) {
    // This relies on AuthCredentials and potentially User having accessible properties.
    // The 'name' might come from a User object or be passed separately.
    throw UnimplementedError('fromDomain() cannot be implemented without generated Freezed parts. Email: ${credentials.email}, Phone: ${credentials.phoneNumber}');
    // Hypothetical example (would error without .freezed parts):
    // return SignUpRequestDto(
    //   name: name ?? '', // Or from a User entity if available
    //   email: credentials.email ?? '',
    //   password: credentials.password ?? '',
    //   phoneNumber: credentials.phoneNumber,
    // );
  }
  */
}
