

import 'banner_list.dart';

class BannerList {
  int? status;
  String? message;
  List<BannerGroup>? categoryGroup;

  BannerList({
    this.status,
    this.message,
    this.categoryGroup,
  });

  factory BannerList.fromJson(
      Map<String, dynamic> categoriesGroupMap,
      ) {
    List<BannerGroup> post = <BannerGroup>[];
    if (categoriesGroupMap['banner'] != null) {
      List<dynamic> categoryGroupItem = categoriesGroupMap['banner'];
      for (var element in categoryGroupItem) {
       /* if (element['bannerType'] == "mobile") {
          post.add(BannerGroup.fromJson(element));
        }*/
        post.add(BannerGroup.fromJson(element));
      }
    }
    return BannerList(
      status: categoriesGroupMap['status'] as int,
      message: categoriesGroupMap['message'] as String,
      categoryGroup: post,
    );
  }

  factory BannerList.initial() => BannerList(
    status: -1,
    message: '',
    categoryGroup: <BannerGroup>[],
  );
}