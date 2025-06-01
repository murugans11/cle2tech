import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shopeein/blocs/payment/payment_success_event.dart';
import 'package:shopeein/blocs/payment/payment_success_state.dart';

import '../../data/exceptions/network_exceptions.dart';
import '../../data/repository/home_repository.dart';


class PaymentSuccessBloc
    extends Bloc<PaymentSuccessEvent, PaymentSuccessState> {
  final HomeRepository homeRepository;

  PaymentSuccessBloc({
    required this.homeRepository,
  }) : super(PaymentSuccessInitial.initial()) {
    on<PaymentSuccess>(_fetchOrderRequestId);
  }

  // get Order Request id
  FutureOr<void> _fetchOrderRequestId(
    PaymentSuccess event,
    Emitter<PaymentSuccessState> emit,
  ) async {
    emit(const PaymentSuccessLoading());

    try {
      final response = await homeRepository.savePaymentSuccess(
          event.token, event.orderId, event.paymentId, event.signature);
      emit(PaymentSuccessLoaded(response: response));
    } catch (e) {
      if (e is CustomException) {
        emit(PaymentSuccessError(message: e.toString()));
      } else {
        emit(PaymentSuccessError(message: 'Unknown error'));
      }
    }
  }
}
