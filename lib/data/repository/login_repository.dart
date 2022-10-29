import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopeein/models/login/login_response.dart';

import '../../models/login/OtpVerifyRequest.dart';
import '../../models/login/RequestOtpResponse.dart';
import '../../models/login/login_requst.dart';
import '../../utils/device/custom_error.dart';
import '../../utils/dio/dio_error_util.dart';
import '../network/apis/home/home_api.dart';
import '../sharedpref/shared_preference_helper.dart';

class LoginRepository {

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // HomeApi object
  final HomeApi _homeApi;

  // constructor
  LoginRepository(this._sharedPrefsHelper,this._homeApi);

  // Login:---------------------------------------------------------------------



  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final LoginResponse loginResponse = await _homeApi.doLogin(loginRequest);
      debugPrint('loginResponse: $loginResponse');
      _sharedPrefsHelper.saveAuthToken(loginResponse.user.token);
      _sharedPrefsHelper.saveIsLoggedIn(true);
      return loginResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }
  Future<RequestOtpResponse> loginWithOTPStep1(String mobileNumber) async {
    try {
      final RequestOtpResponse otpResponse = await _homeApi.loginWithOtpStep1(mobileNumber);
      debugPrint('otpResponse: $otpResponse');
      return otpResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<LoginResponse> loginWithOTPStep2(OtpVerifyRequest otpVerifyRequest) async {
    try {
      final LoginResponse loginResponse = await _homeApi.loginWithOtpStep2(otpVerifyRequest);
      debugPrint('loginResponse: $loginResponse');
      _sharedPrefsHelper.saveAuthToken(loginResponse.user.token);
      _sharedPrefsHelper.saveIsLoggedIn(true);
      return loginResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<void> saveIsLoggedIn(bool value) => _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

}
