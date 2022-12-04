import 'package:bloc/bloc.dart';
import 'package:shopeein/cubit/wishlist/wish_list_response_state.dart';

import '../../data/repository/home_repository.dart';
import '../../models/cart/CartRequest.dart';
import '../../models/cart/CartResponse.dart';
import 'cart_list_response_state.dart';

class CartListResponseCubit extends Cubit<CartListResponseState> {
  final HomeRepository homeRepository;

  CartListResponseCubit({required this.homeRepository})
      : super(CartListResponseInitial());

  void loadCartList(String token) {
    if (state is WishListResponseInitial) {
      emit(CartListResponseInitial());
    }
    homeRepository.getCartList(token).then(
          (cartListResponse) => {
            if (cartListResponse.cartDetails == null)
              {emit(CartListResponseEmpty())}
            else
              {emit(CartListResponseLoaded(cartResponse: cartListResponse))}
          },
        );
  }

  void addUpdateDeleteCart(String token, CartRequest cartRequest) {

    emit(CartListResponseLoaded( cartResponse: CartResponse()));

    homeRepository.addUpdateDeleteCart(token, cartRequest).then(
          (cartListResponse) => {
            if (cartListResponse.cartDetails == null)
              {emit(CartListResponseEmpty())}
            else
              {
                emit(CartListResponseLoaded( cartResponse: cartListResponse))
              }
          },
        );
  }
}
