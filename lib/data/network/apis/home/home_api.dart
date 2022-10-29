import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shopeein/models/banner/banner.dart';

import '../../../../models/categories/category.dart';
import '../../../../models/categoriesbyname/categorieItems.dart';
import '../../../../models/feature/feature_productes.dart';
import '../../../../models/login/OtpVerifyRequest.dart';
import '../../../../models/login/RequestOtpResponse.dart';
import '../../../../models/login/login_requst.dart';
import '../../../../models/login/login_response.dart';
import '../../dio_client.dart';
import '../../constants/endpoints.dart';

class HomeApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  HomeApi(this._dioClient);

  /// Returns list of post in response

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

  Future<CategorieItems> getCategoryProductListByName(String url) async {
    try {
      final viewAllCategoryProductListResponse = await _dioClient.get(url);
      return CategorieItems.fromJson(viewAllCategoryProductListResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LoginResponse> doLogin(LoginRequest loginRequest) async {
    try {
      LoginRequest loginRequest1 =loginRequest ;
      loginRequest1.toJson();
      final loginResponse = await _dioClient.post(Endpoints.loginUsingCrendential, data: loginRequest1);
      return LoginResponse.fromJson(loginResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<RequestOtpResponse> loginWithOtpStep1(String number) async {
    try {
      debugPrint(Endpoints.getNewOtp);
      debugPrint(toJson1(number).toString());
      final  requestOtpResponse = await _dioClient.post(Endpoints.getNewOtp, data: toJson1(number));
      return RequestOtpResponse.fromJson(requestOtpResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LoginResponse> loginWithOtpStep2(OtpVerifyRequest otpVerifyRequest) async {
    try {
      OtpVerifyRequest otpVerifyRequest1 =otpVerifyRequest ;
      otpVerifyRequest1.toJson();
      debugPrint(Endpoints.verifyOTP);
      debugPrint(otpVerifyRequest1.toJson().toString());
      final loginResponse = await _dioClient.post(Endpoints.verifyOTP, data: otpVerifyRequest1);
      return LoginResponse.fromJson(loginResponse);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Map<String, String> toJson1(String loginid) {
    final data = <String, String>{};
    data['mobileNo'] = loginid;
    return data;
  }

}
