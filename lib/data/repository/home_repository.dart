import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopeein/models/banner/banner.dart';
import 'package:shopeein/models/wishlist/toggle_wishList_request.dart';
import 'package:shopeein/models/wishlist/verifywishlist.dart';

import '../../models/address/add_address_request.dart';
import '../../models/cart/CartRequest.dart';
import '../../models/cart/CartResponse.dart';
import '../../models/categories/category.dart';
import '../../models/categoriesbyname/categorieItems.dart';
import '../../models/coupan/coupon_response.dart';
import '../../models/feature/feature_productes.dart';
import '../../models/wishlist/wish_list_response.dart';
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

      debugPrint('categoryList: $categoryList');

      return categoryList;
    } catch (e) {
      debugPrint(e.toString());

      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<BannerList> getBannerList() async {
    try {
      final BannerList bannerList = await _homeApi.getBannerList();

      debugPrint('bannerList: $bannerList');

      return bannerList;
    } catch (e) {
      debugPrint(e.toString());

      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<FeatureProductList> getFeatureProtectList() async {
    try {
      final FeatureProductList featureProductList =
          await _homeApi.getFeatureProductList();

      debugPrint('featureProductList: $featureProductList');

      return featureProductList;
    } catch (e) {
      debugPrint(e.toString());

      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<CategorieItems> getCategoryProductListByName(String url) async {
    try {
      final CategorieItems featureProductList =
          await _homeApi.getCategoryProductListByName(url);

      debugPrint('featureProductList: $featureProductList');

      return featureProductList;
    } catch (e) {
      debugPrint(e.toString());

      return CategorieItems(listingProduct: []);
      //throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<void> toggleWishList(
      ToggleWishListRequest toggleWishListRequest) async {
    try {
      await _homeApi.toggleWishList(toggleWishListRequest);
    } catch (e) {
      debugPrint(e.toString());
      //throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<VerifyWishlist> verifyWishList(String token) async {
    try {
      final VerifyWishlist verifyWishlist =
          await _homeApi.verifyWishList(token);

      debugPrint('verifyWishlist: $verifyWishlist');

      return verifyWishlist;
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<WishListResponse> getWishList(String token) async {
    try {
      final WishListResponse wishListResponse =
          await _homeApi.getWishList(token);

      debugPrint('wishListResponse: $wishListResponse');

      return wishListResponse;
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<CartResponse> getCartList(String token) async {
    try {
      final CartResponse cartResponse = await _homeApi.getCartList(token);

      debugPrint('cartResponse: $cartResponse');

      return cartResponse;
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<CartResponse> addUpdateDeleteCart(
      String token, CartRequest cartRequest) async {
    try {
      final CartResponse cartResponse =
          await _homeApi.addUpdateDeleteCart(token, cartRequest);

      debugPrint('cartResponse: $cartResponse');

      return cartResponse;
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<String> addCustomerAddress(
      String token, AddAddressRequest cartRequest) async {
    try {
      final String addressResponse = await _homeApi.addCustomerAddress(token, cartRequest);

      debugPrint('addressResponse: $addressResponse');

      return addressResponse;

    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<CouponResponse> getCouPanList(String token) async {
    try {
      final CouponResponse cartResponse = await _homeApi.getCouPanList(token);

      debugPrint('cartResponse: $cartResponse');

      return cartResponse;
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }


}
