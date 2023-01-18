
import 'package:equatable/equatable.dart';

import '../../models/OrderOnlineResponse.dart';
import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

class MakeOrderState extends Equatable {

  final NetworkCallStatusEnum status;
  final OrderOtpVerifyRequest orderOtpVerify;
  final CustomError error;

  const MakeOrderState({
    required this.status,
    required this.orderOtpVerify,
    required this.error,
  });

  factory MakeOrderState.initial() {
    return  MakeOrderState(
      status: NetworkCallStatusEnum.initial,
      orderOtpVerify: OrderOtpVerifyRequest(paymentTypeRes: '', requestId: '', key: '', orderId: '', isFullWalletPay: false),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [status, orderOtpVerify, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'MakeOrderState{status: $status, orderOtpVerify: $orderOtpVerify, error: $error}';
  }

  MakeOrderState copyWith({
    NetworkCallStatusEnum? status,
    OrderOtpVerifyRequest? orderOtpVerifyRequest,
    CustomError? error,
  }) {
    return MakeOrderState(
      status: status ?? this.status,
      orderOtpVerify: orderOtpVerifyRequest ?? orderOtpVerify,
      error: error ?? this.error,
    );
  }
}
