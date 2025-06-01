part of 'categoryList_bloc.dart';

// Define states
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();

  factory CategoryInitial.initial() {
    return const CategoryInitial();
  }
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();

  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final CategoryList categoryList;

  const CategoryLoaded({
    required this.categoryList,
  });

  CategoryLoaded copyWith({
    CategoryList? categoryLi,
  }) {
    return CategoryLoaded(
      categoryList: categoryLi ?? categoryList,
    );
  }

  @override
  List<Object> get props => [categoryList];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'CategoryLoaded{categoryList: $categoryList, }';
  }
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
