

class OrderOtpVerifyRequest {


  //only for COD
  late final String requestId;

  //Type to payment
  late final String paymentTypeRes;

  //Online
  late final String orderId;
  late final String key;

  //Wallet money
  late final bool isFullWalletPay;

  OrderOtpVerifyRequest({
    required this.paymentTypeRes,
    required this.requestId,
    required this.orderId,
    required this.key,
    required this.isFullWalletPay,
  });




}
