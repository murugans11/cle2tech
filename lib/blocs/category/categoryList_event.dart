part of 'categoryList_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesItemsEvent extends CategoriesEvent {
  const FetchCategoriesItemsEvent();
}
