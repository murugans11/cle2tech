import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../data/repository/home_repository.dart';
import '../../models/categories/category.dart';

import '../../utils/device/custom_error.dart';
import '../../utils/dio/network_call_status_enum.dart';

part 'categoryList_event.dart';
part 'categoryList_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoryState> {
  final HomeRepository homeRepository;

  CategoriesBloc({
    required this.homeRepository,
  }) : super(CategoryState.initial()) {
    on<FetchCategoriesItemsEvent>(_fetchWeather);
  }

  FutureOr<void> _fetchWeather(
    FetchCategoriesItemsEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if(state.categoryList.categoryGroup?.length ==0){
      emit(state.copyWith(status: NetworkCallStatusEnum.loading));

      try {
        final CategoryList weather = await homeRepository.getCategoryGroup();

        emit(state.copyWith(status: NetworkCallStatusEnum.loaded, categoryList: weather));
      } on CustomError catch (e) {
        emit(state.copyWith(status: NetworkCallStatusEnum.error, error: e));
      }
    }else{
      emit(state.copyWith(status: NetworkCallStatusEnum.loaded, categoryList: state.categoryList));
    }

  }
}
