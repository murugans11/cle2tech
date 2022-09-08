import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:shopeein/models/banner/banner.dart';

import '../../data/repository/home_repository.dart';

import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

import 'bannerList_event.dart';
import 'bannerList_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final HomeRepository homeRepository;

  BannerBloc({
    required this.homeRepository,
  }) : super(BannerState.initial()) {
    on<FetchBannerItemsEvent>(_fetchBannerList);
  }

  FutureOr<void> _fetchBannerList(
    FetchBannerItemsEvent event,
    Emitter<BannerState> emit,
  ) async {
    emit(state.copyWith(status: NetworkCallStatusEnum.loading));

    try {
      final BannerList weather = await homeRepository.getBannerList();

      emit(state.copyWith(
          status: NetworkCallStatusEnum.loaded, categoryList: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
    }
  }
}
