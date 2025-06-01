import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_response_dto.freezed.dart';
part 'user_response_dto.g.dart';

// Mapper comments:
// - Mapper from UserResponseDto to domain User entity.
//   UserResponseDto.id -> User.id
//   UserResponseDto.name -> User.name (or API specific key e.g., userName, fullName)
//   UserResponseDto.email -> User.email (or API specific key e.g., userEmail)
//   UserResponseDto.phoneNumber -> User.phoneNumber
//   UserResponseDto.profilePicUrl -> User.profileImageUrl
// - Consider if API provides fields not in domain User that might be useful elsewhere
//   or if some User fields are not provided by this DTO (e.g. if User has local-only fields).

@freezed
class UserResponseDto with _$UserResponseDto {
  const factory UserResponseDto({
    required String id,
    @JsonKey(name: 'name') String? name, // Assuming API key is 'name'
    @JsonKey(name: 'email') String? email, // Assuming API key is 'email'
    @JsonKey(name: 'phone_number') String? phoneNumber, // Assuming API key is 'phone_number'
    @JsonKey(name: 'profile_image_url') String? profilePicUrl, // Assuming API key is 'profile_image_url'
    // Include other relevant fields from typical user API responses,
    // e.g., is_verified, created_at, etc.
  }) = _UserResponseDto;

  factory UserResponseDto.fromJson(Map<String, dynamic> json) => _$UserResponseDtoFromJson(json);

  /*
  // Assuming import '../../../domain/entities/auth/user.dart';

  User toDomain() {
    // This conversion relies on the actual structure of User and UserResponseDto
    // and potentially on User.fromJson if User itself has complex fields.
    // Since .freezed.dart files are not generated, direct instantiation might fail
    // if User has factory constructors or specific requirements from Freezed.
    throw UnimplementedError('toDomain() cannot be implemented without generated Freezed parts for User and UserResponseDto. Expected fields: id=$id, name=$name, email=$email');
    // Hypothetical example (would error without .freezed parts):
    // return User(id: id, name: name ?? '', email: email ?? '', phoneNumber: phoneNumber, profileImageUrl: profilePicUrl);
  }
  */
}
