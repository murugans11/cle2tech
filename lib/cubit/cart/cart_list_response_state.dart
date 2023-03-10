import 'package:flutter/material.dart'hide ModalBottomSheetRoute;

import '../../models/cart/CartResponse.dart';

@immutable
abstract class CartListResponseState {
  const CartListResponseState();
}

class CartListResponseInitial extends CartListResponseState {}

class CartListResponseEmpty extends CartListResponseState {}

class CartListResponseError extends CartListResponseState {
  final String errorMessage;

  const CartListResponseError({required this.errorMessage});
}

class CartListResponseLoaded extends CartListResponseState {
  final CartResponse cartResponse;

  const CartListResponseLoaded({required this.cartResponse});
}

class CreateOrderRequestLoaded extends CartListResponseState {
  final String requestId;

  const CreateOrderRequestLoaded({required this.requestId});
}
