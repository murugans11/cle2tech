import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/home_repository.dart';
import '../../models/feature/feature_productes.dart';
import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

part 'feature_product_list_event.dart';

part 'feature_product_list_state.dart';

class FeatureProductListBloc
    extends Bloc<FeatureProductListEvent, FeatureProductListState> {
  final HomeRepository homeRepository;

  FeatureProductListBloc({
    required this.homeRepository,
  }) : super(FeatureProductListState.initial()) {
    on<FetchFeatureProductItemsEvent>(_fetchFeatureProduct);
  }

  FutureOr<void> _fetchFeatureProduct(
    FeatureProductListEvent event,
    Emitter<FeatureProductListState> emit,
  ) async {
    emit(state.copyWith(status: NetworkCallStatusEnum.loading));

    try {
      final FeatureProductList featureProductList =
          await homeRepository.getFeatureProtectList();

      emit(state.copyWith(
          status: NetworkCallStatusEnum.loaded,
          featureProductLists: featureProductList));
    } on CustomError catch (e) {
      emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
    }
  }
}
