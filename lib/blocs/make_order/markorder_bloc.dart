import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../data/exceptions/network_exceptions.dart';
import '../../data/repository/home_repository.dart';
import '../../models/OrderOnlineResponse.dart';
import 'markorder_event.dart';
import 'markorder_state.dart';

class MakeOrderBloc extends Bloc<MakeOrderEvent, MakeOrderState> {
  final HomeRepository homeRepository;

  MakeOrderBloc({
    required this.homeRepository,
  }) : super(MakeOrderInitial.initial()) {
    on<MakeOrderRequestEvent>(_fetchOrderRequestId);

    on<MakeCODOrderOtpVerifyEvent>(_verifyCODOrderVerifyOtp);
  }

  // get Order Request id
  FutureOr<void> _fetchOrderRequestId(
    MakeOrderRequestEvent event,
    Emitter<MakeOrderState> emit,
  ) async {

    emit(const MakeOrderLoading());

    try {
      final requestId = await homeRepository.makeAnOrder(event.token, event.id, event.deliveryAddress, event.paymentType, event.canUseWallet);
      emit(MakeOrderLoaded(orderOtpVerify: requestId));
    } catch (e) {
      if (e is CustomException) {
        emit(MakeOrderError(message: e.toString()));
      } else {
        emit(MakeOrderError(message: 'Unknown error'));
      }
    }
  }

  //Verify COD otp verify
  FutureOr<void> _verifyCODOrderVerifyOtp(
    MakeCODOrderOtpVerifyEvent event,
    Emitter<MakeOrderState> emit,
  ) async {
    emit(const MakeOrderLoading());

    try {
      final requestId = await homeRepository.verifyOtpOrder(
          event.token, event.otp, event.requestId, event.orderId);
      final result = OrderOtpVerifyRequest(
          paymentTypeRes: '',
          requestId: '',
          key: '',
          orderId: '',
          isFullWalletPay: false);
      emit(MakeOrderLoaded(orderOtpVerify: result));
    } catch (e) {
      if (e is CustomException) {
        emit(MakeOrderError(message: e.toString()));
      } else {
        emit(MakeOrderError(message: 'Unknown error'));
      }
    }
  }
}
