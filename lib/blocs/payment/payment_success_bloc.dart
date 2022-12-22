


import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shopeein/blocs/payment/payment_success_event.dart';
import 'package:shopeein/blocs/payment/payment_success_state.dart';

import '../../data/repository/home_repository.dart';
import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';




class PaymentSuccessBloc extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {

  final HomeRepository homeRepository;

  PaymentSuccessBloc({
    required this.homeRepository,
  }) : super(PaymentSuccessState.initial()) {
    on<PaymentSuccess>(_fetchOrderRequestId);

  }

  // get Order Request id
  FutureOr<void> _fetchOrderRequestId(
      PaymentSuccess event,
      Emitter<PaymentSuccessState> emit,) async {

    emit(state.copyWith(status: NetworkCallStatusEnum.loading));
    try {

      final  response = await homeRepository.savePaymentSuccess(event.token, event.orderId, event.paymentId, event.signature);

      emit(state.copyWith(status: NetworkCallStatusEnum.loaded, response1: response));

    } on CustomError catch (e) {
      emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
    }

  }


}

