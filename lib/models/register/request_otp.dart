
import '../login/RequestOtpResponse.dart';

class RequestOtp {

  late final int toggleLoginOrNewRegister;
  late final String otp;
  late final RequestOtpResponse requestOtpResponse;

  RequestOtp({
    required this.toggleLoginOrNewRegister,
    required this.otp,
    required this.requestOtpResponse,
  });

}


