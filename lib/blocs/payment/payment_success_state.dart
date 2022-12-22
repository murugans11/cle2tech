

import 'package:equatable/equatable.dart';

import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

class PaymentSuccessState extends Equatable {

  final NetworkCallStatusEnum status;
  final String response;
  final CustomError error;

  const PaymentSuccessState({
    required this.status,
    required this.response,
    required this.error,
  });

  factory PaymentSuccessState.initial() {
    return  const PaymentSuccessState(
      status: NetworkCallStatusEnum.initial,
      response: '',
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, response, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'PaymentSuccessState{status: $status, response: $response, error: $error}';
  }

  PaymentSuccessState copyWith({
    NetworkCallStatusEnum? status,
    String? response1,
    CustomError? error,
  }) {
    return PaymentSuccessState(
      status: status ?? this.status,
      response: response1 ?? response,
      error: error ?? this.error,
    );
  }
}
