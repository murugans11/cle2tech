import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/exceptions/network_exceptions.dart';
import '../../data/repository/home_repository.dart';
import '../../models/feature/feature_productes.dart';
import '../../utils/dio/network_call_status_enum.dart';

part 'feature_product_list_event.dart';

part 'feature_product_list_state.dart';

class FeatureProductListBloc
    extends Bloc<FeatureProductListEvent, FeatureProductListState> {
  final HomeRepository homeRepository;

  FeatureProductListBloc({
    required this.homeRepository,
  }) : super(FeatureProductListInitial.initial()) {
    on<FeatureProductListEvent>(_fetchFeatureProduct);
  }

  FutureOr<void> _fetchFeatureProduct(
    FeatureProductListEvent event,
    Emitter<FeatureProductListState> emit,
  ) async {
    if (event is FetchFeatureProductItemsEvent) {
      if (state is FeatureProductListLoaded &&
          (state as FeatureProductListLoaded)
                  .featureProductList
                  .featureProduct
                  ?.length ==
              0) {
        emit((state as FeatureProductListLoaded).copyWith(
            featureProductLists:
                (state as FeatureProductListLoaded).featureProductList));
        return;
      }

      emit(const FeatureProductListLoading());

      try {
        final FeatureProductList featureProductList =
            await homeRepository.getFeatureProtectList();
        emit(FeatureProductListLoaded(featureProductList: featureProductList));
      } catch (e) {
        if (e is CustomException) {
          emit(FeatureProductListError(message: e.toString()));
        } else {
          emit(FeatureProductListError(message: 'Unknown error'));
        }
      }
    }
  }
}
