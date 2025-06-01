class LoginRequest {
  late final String loginId;
  late final String password;

  LoginRequest({
    required this.loginId,
    required this.password,
  });

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['loginId'] = loginId;
    data['password'] = password;
    return data;
  }

}
