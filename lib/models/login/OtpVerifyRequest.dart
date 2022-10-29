class OtpVerifyRequest {
  OtpVerifyRequest({
    required this.loginId,
    required this.otp,
    required this.requestId,
  });

  late final String loginId;
  late final String otp;
  late final String requestId;

  Map<String, String> toJson() {
    final data = <String, String>{};
    data['loginId'] = loginId;
    data['otp'] = otp;
    data['requestId'] = requestId;
    return data;
  }
}
