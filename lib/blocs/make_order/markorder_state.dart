
import 'package:equatable/equatable.dart';

import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

class MakeOrderState extends Equatable {

  final NetworkCallStatusEnum status;
  final String requestId;
  final CustomError error;

  const MakeOrderState({
    required this.status,
    required this.requestId,
    required this.error,
  });

  factory MakeOrderState.initial() {
    return const MakeOrderState(
      status: NetworkCallStatusEnum.initial,
      requestId: '',
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, requestId, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'MakeOrderState{status: $status, requestId: $requestId, error: $error}';
  }

  MakeOrderState copyWith({
    NetworkCallStatusEnum? status,
    String? requestIdResponse,
    CustomError? error,
  }) {
    return MakeOrderState(
      status: status ?? this.status,
      requestId: requestIdResponse ?? requestId,
      error: error ?? this.error,
    );
  }
}
