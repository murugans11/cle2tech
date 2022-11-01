
import 'package:flutter/material.dart';

import '../../models/wishlist/wish_list_response.dart';

@immutable
abstract class WishListResponseState  {
  const WishListResponseState();
}

class WishListResponseInitial extends WishListResponseState {}

class WishListResponseEmpty extends WishListResponseState {}

class WishListResponseLoaded extends WishListResponseState {

  final WishListResponse wishListResponse;

   const WishListResponseLoaded({required this.wishListResponse});

}
