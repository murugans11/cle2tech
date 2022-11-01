import 'package:bloc/bloc.dart';
import 'package:shopeein/cubit/wishlist/wish_list_response_state.dart';


import '../../data/repository/home_repository.dart';



class WishListResponseCubit extends Cubit<WishListResponseState> {

  final HomeRepository homeRepository;

  WishListResponseCubit({required this.homeRepository}) : super(WishListResponseInitial());

  void loadWishList(String token) {

    if (state is WishListResponseInitial) {
      emit(WishListResponseInitial());
    }
    homeRepository.getWishList(token).then(
          (wishListResponse) => {
            if(wishListResponse.listingProduct == null) {
              emit(WishListResponseEmpty())
            }
            else{
             emit(WishListResponseLoaded(wishListResponse: wishListResponse))
           }
          },
        );
  }

}
