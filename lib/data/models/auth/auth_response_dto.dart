import 'package:freezed_annotation/freezed_annotation.dart';
import './user_response_dto.dart'; // Assuming it contains a User DTO

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

// Mapper comments:
// - Mapper from AuthResponseDto to a domain object (perhaps User and token separately,
//   or a combined domain AuthResult entity that holds both User and token).
// - The existing LoginResponse has User details nested. This DTO does the same with UserResponseDto.
// - The token is at the top level of this DTO, which is a common pattern.
//   The existing LoginResponse's User model also had a 'token' field, which might be redundant
//   if the token is already present at the top level of the AuthResponseDto.

@freezed
class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    required String token,
    @JsonKey(name: 'user') UserResponseDto? user, // API might use 'user' or 'data' or similar for user object
    // Other potential fields: expires_in, refresh_token
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) => _$AuthResponseDtoFromJson(json);
}
