
import 'package:flutter/material.dart';

import '../../models/cart/CartResponse.dart';


@immutable
abstract class CartListResponseState  {
  const CartListResponseState();
}

class CartListResponseInitial extends CartListResponseState {}

class CartListResponseEmpty extends CartListResponseState {}

class CartListResponseLoaded extends CartListResponseState {

  final CartResponse cartResponse;

  const CartListResponseLoaded({required this.cartResponse});

}
