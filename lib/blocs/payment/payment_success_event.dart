

import 'package:equatable/equatable.dart';

abstract class PaymentSuccessEvent extends Equatable {
  const PaymentSuccessEvent();

  @override
  List<Object> get props => [];
}

class PaymentSuccess extends PaymentSuccessEvent {

  final token;
  final orderId;
  final paymentId;
  final signature;

  @override
  List<Object> get props => [token, orderId, paymentId, signature];

  const PaymentSuccess({
    required this.token,
    required this.orderId,
    required this.paymentId,
    required this.signature,
  });
}



