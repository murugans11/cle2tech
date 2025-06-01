import 'package:equatable/equatable.dart';

abstract class MakeOrderEvent extends Equatable {
  const MakeOrderEvent();

  @override
  List<Object> get props => [];
}

class MakeOrderRequestEvent extends MakeOrderEvent {
  final token;
  final id;
  final deliveryAddress;
  final paymentType;
  final bool canUseWallet;

  @override
  List<Object> get props => [token, id, deliveryAddress, paymentType,canUseWallet];

  const MakeOrderRequestEvent({
    required this.token,
    required this.id,
    required this.paymentType,
    required this.deliveryAddress,
    required this.canUseWallet,
  });
}

class MakeCODOrderOtpVerifyEvent extends MakeOrderEvent {
  final token;
  final orderId;
  final requestId;
  final otp;

  @override
  List<Object> get props => [token, orderId, requestId, otp];

  const MakeCODOrderOtpVerifyEvent({
    required this.token,
    required this.orderId,
    required this.otp,
    required this.requestId,
  });
}
