import 'package:bloc/bloc.dart';
import 'package:shopeein/cubit/wishlist/wish_list_response_state.dart';


import '../../data/repository/home_repository.dart';
import 'cart_list_response_state.dart';



class CartListResponseCubit extends Cubit<CartListResponseState> {

  final HomeRepository homeRepository;

  CartListResponseCubit({required this.homeRepository}) : super(CartListResponseInitial());

  void loadCartList(String token) {

    if (state is WishListResponseInitial) {
      emit(CartListResponseInitial());
    }
    homeRepository.getCartList(token).then(
          (cartListResponse) => {
            if(cartListResponse.cartDetails == null) {
              emit(CartListResponseEmpty())
            }
            else{
             emit(CartListResponseLoaded(cartResponse: cartListResponse))
           }
          },
        );
  }

}
