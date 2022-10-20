import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/home_repository.dart';
import '../../models/categoriesbyname/categorieItems.dart';
import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

part 'categories_items_by_name_event.dart';

part 'categories_items_by_name_state.dart';

class CategoriesItemsByNameBloc
    extends Bloc<CategoriesItemsByNameEvent, CategoriesItemsByNameInitial> {
  final HomeRepository homeRepository;

  CategoriesItemsByNameBloc({
    required this.homeRepository,
  }) : super(CategoriesItemsByNameInitial.initial()) {
    on<FetchCategoriesItemsByNameEvent>(_fetchWeather);
  }

  FutureOr<void> _fetchWeather(
    FetchCategoriesItemsByNameEvent event,
    Emitter<CategoriesItemsByNameInitial> emit,
  ) async {
    emit(state.copyWith(status: NetworkCallStatusEnum.loading));
    try {
      final CategorieItems categorieItems = await homeRepository.getCategoryProductListByName(event.url);

      emit(state.copyWith(
          status: NetworkCallStatusEnum.loaded, categorieItems: categorieItems));
    } on CustomError catch (e) {
      emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
    }
  }
}
