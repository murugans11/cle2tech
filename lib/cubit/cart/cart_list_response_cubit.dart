import 'package:bloc/bloc.dart';
import 'package:shopeein/data/exceptions/network_exceptions.dart';


import '../../data/repository/home_repository.dart';
import '../../models/cart/CartRequest.dart';
import '../../models/cart/CartResponse.dart';
import 'cart_list_response_state.dart';

class CartListResponseCubit extends Cubit<CartListResponseState> {
  final HomeRepository homeRepository;

  CartListResponseCubit({required this.homeRepository})
      : super(CartListResponseInitial());


  Future<void> loadCartList(String token) async {
    if (state is CartListResponseInitial) {
      emit(CartListResponseInitial());
    }
    try {
      final cartListResponse = await homeRepository.getCartList(token);
      if (cartListResponse.cartDetails == null) {
        emit(CartListResponseEmpty());
      } else {
        emit(CartListResponseLoaded(cartResponse: cartListResponse));
      }
    } catch (error) {
      if(error is CustomException){
        emit(CartListResponseError(errorMessage: error.message));
      }else{
        emit(CartListResponseError(errorMessage: error.toString()));
      }
    }
  }

  Future<void> addUpdateDeleteCart(String token, CartRequest cartRequest) async {
    emit(CartListResponseLoaded(cartResponse: CartResponse()));

    try {
      final cartListResponse = await homeRepository.addUpdateDeleteCart(token, cartRequest);
      if (cartListResponse.cartDetails == null) {
        emit(CartListResponseEmpty());
      } else {
        emit(CartListResponseLoaded(cartResponse: cartListResponse));
      }
    } catch (error) {
      if(error is CustomException){
        emit(CartListResponseError(errorMessage: error.message));
      }else{
        emit(CartListResponseError(errorMessage: error.toString()));
      }
    }
  }

  Future<void> applyCoupon(String token, String couponCode, String orderId) async {
    emit(CartListResponseLoaded(cartResponse: CartResponse()));

    try {
      final cartListResponse = await homeRepository.applyCoupon(token, couponCode, orderId);
      if (cartListResponse.cartDetails == null) {
        emit(CartListResponseEmpty());
      } else {
        emit(CartListResponseLoaded(cartResponse: cartListResponse));
      }
    } catch (error) {
      if(error is CustomException){
        emit(CartListResponseError(errorMessage: error.message));
      }else{
        emit(CartListResponseError(errorMessage: error.toString()));
      }
    }
  }


}
