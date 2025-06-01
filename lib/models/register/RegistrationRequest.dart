class RegistrationRequest {
  RegistrationRequest({
    required this.mobileNo,
    required this.password,
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.otp,
    required this.requestId,
  });
  late final String mobileNo;
  late final String password;
  late final String gender;
  late final String firstName;
  late final String lastName;
  late final String otp;
  late final String requestId;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['mobileNo'] = mobileNo;
    data['password'] = password;
    data['gender'] = gender;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['otp'] = otp;
    data['requestId'] = requestId;
    return data;
  }
}