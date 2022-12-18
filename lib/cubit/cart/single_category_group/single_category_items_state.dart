
import 'package:flutter/material.dart';

import '../../../models/categoriesbyname/categorieItems.dart';

@immutable
abstract class SingleCategoryItemState {}

class SingleCategoryInitial extends SingleCategoryItemState {}

class SingleCategoryLoaded extends SingleCategoryItemState {

  final CategorieItems posts;

  SingleCategoryLoaded({required this.posts});

}

class SingleCategoryLoading extends SingleCategoryItemState {
  final CategorieItems oldPosts;
  final bool isFirstFetch;

  SingleCategoryLoading(this.oldPosts, {this.isFirstFetch = false});
}
