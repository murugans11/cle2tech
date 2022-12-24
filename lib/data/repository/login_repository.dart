import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopeein/models/login/login_response.dart';
import 'package:shopeein/models/register/RegistrationRequest.dart';

import '../../models/login/OtpVerifyRequest.dart';
import '../../models/login/RequestOtpResponse.dart';
import '../../models/login/login_requst.dart';
import '../../models/wishlist/wish_list_response.dart';
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
  LoginRepository(this._sharedPrefsHelper, this._homeApi);

  // Login:---------------------------------------------------------------------

  Future<LoginResponse> loginWithCredential(LoginRequest loginRequest) async {
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

  Future<RequestOtpResponse> loginWithPhoneNumber(
      String mobileNumber, int toggleLoginOrNewRegister) async {
    try {
      final RequestOtpResponse otpResponse =
          await _homeApi.getOtp(mobileNumber, toggleLoginOrNewRegister);

      debugPrint('otpResponse: $otpResponse');

      return otpResponse;
    } catch (e) {
      debugPrint(e.toString());

      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<LoginResponse> verifyLoginWithPhoneNumberByOtp(
      OtpVerifyRequest otpVerifyRequest) async {
    try {
      final LoginResponse loginResponse =
          await _homeApi.verifyOtp(otpVerifyRequest);

      debugPrint('loginResponse: $loginResponse');

      _sharedPrefsHelper.saveAuthToken(loginResponse.user.token);

      _sharedPrefsHelper.saveIsLoggedIn(true);

      return loginResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<LoginResponse> verifyRegisterWithPhoneNumberByOtp(
      RegistrationRequest registrationRequest) async {
    try {
      final LoginResponse loginResponse =
          await _homeApi.verifyRegisterOtp(registrationRequest);

      debugPrint('registerResponse: $loginResponse');

      _sharedPrefsHelper.saveAuthToken(loginResponse.user.token);

      _sharedPrefsHelper.saveIsLoggedIn(true);

      return loginResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<WishListResponse> updateProfile(
    String firstName,
    String lastName,
    String gender,
  ) async {
    try {
      String token = await _sharedPrefsHelper.authToken ?? '';
      final WishListResponse profileResponse =
          await _homeApi.updateProfile(token, firstName, lastName, gender);

      debugPrint('profileResponse: $profileResponse');

      return profileResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }

  Future<String> changePassword(
    String password,
    String passwordConfirmation,
  ) async {
    try {
      String token = await _sharedPrefsHelper.authToken ?? '';
      final profileResponse = await _homeApi.changePassword( token, password, passwordConfirmation);

      debugPrint('profileResponse: $profileResponse');

      return profileResponse;
    } catch (e) {
      debugPrint(e.toString());
      throw CustomError(errMsg: DioErrorUtil.handleError(e as DioError));
    }
  }
}
