

class OrderOtpVerifyRequest {


  //only for COD
  late final String requestId;

  //Type to payment
  late final String paymentTypeRes;

  //Online
  late final String orderId;
  late final String key;

  OrderOtpVerifyRequest({
    required this.paymentTypeRes,
    required this.requestId,
    required this.orderId,
    required this.key,
  });




}
