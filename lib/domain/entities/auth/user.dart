import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    // Consider adding fields like:
    // String? address,
    // DateTime? dateOfBirth,
    // bool? isVerified,
  }) = _User;
}
