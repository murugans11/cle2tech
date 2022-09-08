part of 'categoryList_bloc.dart';



class CategoryState extends Equatable {

  final NetworkCallStatusEnum status;
  final CategoryList categoryList;
  final CustomError error;

  const CategoryState({
    required this.status,
    required this.categoryList,
    required this.error,
  });

  factory CategoryState.initial() {
    return CategoryState(
      status: NetworkCallStatusEnum.initial,
      categoryList: CategoryList.initial(),
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, categoryList, error];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'CategoryState{status: $status, categoryList: $categoryList, error: $error}';
  }

  CategoryState copyWith({
    NetworkCallStatusEnum? status,
    CategoryList? categoryList,
    CustomError? error,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categoryList: categoryList ?? this.categoryList,
      error: error ?? this.error,
    );
  }
}
