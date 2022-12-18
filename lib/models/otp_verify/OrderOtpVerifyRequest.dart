

class OrderOtpVerifyRequest {

  late final String token;
  late final String requestId;
  late final String orderId;

  OrderOtpVerifyRequest({
    required this.token,
    required this.requestId,
    required this.orderId,
  });


}
