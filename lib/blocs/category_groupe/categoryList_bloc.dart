import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/exceptions/network_exceptions.dart';
import '../../data/repository/home_repository.dart';
import '../../models/categories/category.dart';


part 'categoryList_event.dart';

part 'categoryList_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoryState> {
  final HomeRepository homeRepository;

  CategoriesBloc({
    required this.homeRepository,
  }) : super(CategoryInitial.initial()) {
    on<CategoriesEvent>(_fetchWeather);
  }

  FutureOr<void> _fetchWeather(
    CategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (event is FetchCategoriesItemsEvent) {
      if (state is CategoryLoaded &&
          (state as CategoryLoaded).categoryList.categoryGroup?.length == 0) {
        emit((state as CategoryLoaded)
            .copyWith(categoryLi: (state as CategoryLoaded).categoryList));
        return;
      }

      emit(const CategoryLoading());

      try {
        final CategoryList weather = await homeRepository.getCategoryGroup();
        emit(CategoryLoaded(categoryList: weather));
      } catch (e) {
        if (e is CustomException) {
          emit(CategoryError(message: e.toString()));
        } else {
          emit(const CategoryError(message: 'Unknown error'));
        }
      }
    }
  }
}
