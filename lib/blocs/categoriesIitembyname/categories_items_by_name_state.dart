part of 'categories_items_by_name_bloc.dart';

class CategoriesItemsByNameInitial extends Equatable {
  final NetworkCallStatusEnum status;
  final CategorieItems categorieItems;
  final CustomError error;

  const CategoriesItemsByNameInitial({
    required this.status,
    required this.categorieItems,
    required this.error,
  });

  factory CategoriesItemsByNameInitial.initial() {
    return CategoriesItemsByNameInitial(
      status: NetworkCallStatusEnum.initial,
      categorieItems: CategorieItems.initial(),
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, categorieItems, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'CategoryState{status: $status, categoryList: $categorieItems, error: $error}';
  }

  CategoriesItemsByNameInitial copyWith({
    NetworkCallStatusEnum? status,
    CategorieItems? categorieItems,
    CustomError? error,
  }) {
    return CategoriesItemsByNameInitial(
      status: status ?? this.status,
      categorieItems: categorieItems ?? this.categorieItems,
      error: error ?? this.error,
    );
  }
}
