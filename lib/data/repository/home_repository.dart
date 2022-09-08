import 'package:dio/dio.dart';
import 'package:shopeein/models/banner/banner.dart';

import '../../models/categories/category.dart';
import '../../models/feature/feature_productes.dart';
import '../../utils/device/custom_error.dart';
import '../../utils/dio/dio_error_util.dart';
import '../network/apis/home/home_api.dart';


class HomeRepository {
  // api objects
  final HomeApi _homeApi;

  HomeRepository(
    this._homeApi,
  );

  Future<CategoryList> getCategoryGroup() async {
    try {
      final CategoryList categoryList = await _homeApi.getCategoryGroup();
      print('categoryList: $categoryList');
      return categoryList;
    } catch (e) {
      print(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<BannerList> getBannerList() async {
    try {
      final BannerList bannerList = await _homeApi.getBannerList();
      print('bannerList: $bannerList');
      return bannerList;
    } catch (e) {
      print(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<FeatureProductList> getFeatureProtectList() async {
    try {
      final FeatureProductList featureProductList = await _homeApi.getFeatureProductList();
      print('featureProductList: $featureProductList');
      return featureProductList;
    } catch (e) {
      print(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }
}
