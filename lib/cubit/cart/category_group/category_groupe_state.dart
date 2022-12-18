part of 'category_group_cubit.dart';

@immutable
abstract class CategoryGroupItemState {}

class CategoryGroupInitial extends CategoryGroupItemState {}

class CategoryGroupLoaded extends CategoryGroupItemState {

  final CategorieItems posts;

  CategoryGroupLoaded({required this.posts});

}

class CategoryGroupLoading extends CategoryGroupItemState {
  final CategorieItems oldPosts;
  final bool isFirstFetch;

  CategoryGroupLoading(this.oldPosts, {this.isFirstFetch = false});
}
