import 'dart:async';

import 'package:shopeein/models/banner/banner.dart';

import '../../../../models/categories/category.dart';
import '../../../../models/feature/feature_productes.dart';
import '../../dio_client.dart';
import '../../constants/endpoints.dart';

class HomeApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  HomeApi(this._dioClient);

  /// Returns list of post in response

  Future<CategoryList> getCategoryGroup() async {
    try {
      final categoryGroupResponse =
          await _dioClient.get(Endpoints.getCategoryGroup);
      return CategoryList.fromJson(categoryGroupResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<BannerList> getBannerList() async {
    try {
      final categoryGroupResponse =
          await _dioClient.get(Endpoints.getHomePageBanner);
      return BannerList.fromJson(categoryGroupResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<FeatureProductList> getFeatureProductList() async {
    try {
      final featureProductResponse =
          await _dioClient.get(Endpoints.getFeatureProductList);
      return FeatureProductList.fromJson(featureProductResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
