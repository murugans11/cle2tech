


import 'dart:async';

import 'package:bloc/bloc.dart';



import '../../data/repository/home_repository.dart';

import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';
import 'markorder_event.dart';
import 'markorder_state.dart';



class MakeOrderBloc extends Bloc<MakeOrderEvent, MakeOrderState> {

  final HomeRepository homeRepository;

  MakeOrderBloc({
    required this.homeRepository,
  }) : super(MakeOrderState.initial()) {
    on<MakeOrderRequestEvent>(_fetchOrderRequestId);
    on<MakeCODOrderOtpVerifyEvent>(_verifyCODOrderVerifyOtp);
  }

  // get Order Request id
  FutureOr<void> _fetchOrderRequestId(
      MakeOrderRequestEvent event,
      Emitter<MakeOrderState> emit,
      ) async {

    emit(state.copyWith(status: NetworkCallStatusEnum.loading));
    try {
      final  requestId = await homeRepository.makeAnOrder(event.token, event.id, event.deliveryAddress, event.paymentType);
      emit(state.copyWith(status: NetworkCallStatusEnum.loaded, requestIdResponse: requestId));
    } on CustomError catch (e) {
      emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
    }
  }


  //Verify COD otp verify
  FutureOr<void> _verifyCODOrderVerifyOtp(
      MakeCODOrderOtpVerifyEvent event,
      Emitter<MakeOrderState> emit,
      ) async {

    emit(state.copyWith(status: NetworkCallStatusEnum.loading));
    try {
      final  requestId = await homeRepository.verifyOtpOrder( event.token, event.otp, event.requestId, event.orderId  );
      emit(state.copyWith(status: NetworkCallStatusEnum.loaded, requestIdResponse: requestId));
    } on CustomError catch (e) {
      emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
    }
  }


}
