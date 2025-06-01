import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:shopeein/cubit/wishlist/wish_list_response_state.dart';


import '../../data/exceptions/network_exceptions.dart';
import '../../data/repository/home_repository.dart';



class WishListResponseCubit extends Cubit<WishListResponseState> {

  final HomeRepository homeRepository;

  WishListResponseCubit({required this.homeRepository}) : super(WishListResponseInitial());



  void loadWishList(String token) async {
    if (state is WishListResponseInitial) {
      emit(WishListResponseInitial());
    }

    try {
      final wishListResponse = await homeRepository.getWishList(token);
      if (wishListResponse.listingProduct == null) {
        emit(WishListResponseEmpty());
      } else {
        emit(WishListResponseLoaded(wishListResponse: wishListResponse));
      }
    } catch (error) {
      if(error is CustomException){
        debugPrint(error.message);
      }else{
        debugPrint(error.toString());
      }
    }
  }

}
