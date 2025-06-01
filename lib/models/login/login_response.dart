class LoginResponse {

  late final User user;
  LoginResponse({
    required this.user,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

}

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.emailId,
    required this.token,
  });

  late final String firstName;
  late final String lastName;
  late final String mobileNo;
  late final String emailId;
  late final String token;

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNo'] = mobileNo;
    data['emailId'] = emailId;
    data['token'] = token;
    return data;
  }
}
