import 'package:equatable/equatable.dart';

import '../../models/OrderOnlineResponse.dart';

// Define states
abstract class MakeOrderState extends Equatable {
  const MakeOrderState();

  @override
  List<Object> get props => [];
}

class MakeOrderInitial extends MakeOrderState {
  const MakeOrderInitial();

  factory MakeOrderInitial.initial() {
    return const MakeOrderInitial();
  }
}

class MakeOrderLoading extends MakeOrderState {
  const MakeOrderLoading();

  @override
  List<Object> get props => [];
}

class MakeOrderLoaded extends MakeOrderState {
  final OrderOtpVerifyRequest orderOtpVerify;

  const MakeOrderLoaded({
    required this.orderOtpVerify,
  });

  @override
  List<Object> get props => [orderOtpVerify];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'MakeOrderState{orderOtpVerify: $orderOtpVerify, }';
  }

  MakeOrderState copyWith({
    OrderOtpVerifyRequest? orderOtpVerifyRequest,
  }) {
    return MakeOrderLoaded(
      orderOtpVerify: orderOtpVerifyRequest ?? orderOtpVerify,
    );
  }
}

class MakeOrderError extends MakeOrderState {
  final String message;

  const MakeOrderError({required this.message});

  @override
  List<Object> get props => [message];
}
