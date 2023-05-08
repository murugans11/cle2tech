import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:shopeein/models/banner/banner.dart';

import '../../data/exceptions/network_exceptions.dart';
import '../../data/repository/home_repository.dart';


import 'bannerList_event.dart';
import 'bannerList_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final HomeRepository homeRepository;

  BannerBloc({
    required this.homeRepository,
  }) : super(BannerInitial.initial()) {
    on<BannerEvent>(_fetchBannerList);
  }

  FutureOr<void> _fetchBannerList(
    BannerEvent event,
    Emitter<BannerState> emit,
  ) async {
    if (event is FetchBannerItemsEvent) {

      if (state is BannerLoaded &&
          (state as BannerLoaded).bannerList.categoryGroup?.length == 0) {
        emit((state as BannerLoaded)
            .copyWith(categoryList: (state as BannerLoaded).bannerList));
        return;
      }

      emit(const BannerLoading());

      try {
        final BannerList weather = await homeRepository.getBannerList();
        emit(BannerLoaded(bannerList: weather));
      } catch (e) {
        if (e is CustomException) {
          emit(BannerError(message: e.toString()));
        } else {
          emit(BannerError(message: 'Unknown error'));
        }
      }
    }
  }
}
