import 'category_group.dart';

class CategoryList {
  int? status;
  String? message;
  List<CategoriesGroup>? categoryGroup;

  CategoryList({
    this.status,
    this.message,
    this.categoryGroup,
  });

  factory CategoryList.fromJson(
    Map<String, dynamic> categoriesGroupMap,
  ) {
    List<CategoriesGroup> post = <CategoriesGroup>[];
    if (categoriesGroupMap['categoryGroup'] != null) {
      List<dynamic> categoryGroupItem = categoriesGroupMap['categoryGroup'];
      for (var element in categoryGroupItem) {
        if (element['menuType'] == "HEADER") {
          post.add(CategoriesGroup.fromJson(element));
        }
      }
    }
    return CategoryList(
      status: categoriesGroupMap['status'] as int,
      message: categoriesGroupMap['message'] ,
      categoryGroup: post,
    );
  }

  factory CategoryList.initial() => CategoryList(
        status: -1,
        message: '',
        categoryGroup: <CategoriesGroup>[],
      );
}
