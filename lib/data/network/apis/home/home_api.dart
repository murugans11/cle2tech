import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shopeein/models/banner/banner.dart';
import 'package:dio/dio.dart';
import 'package:shopeein/models/wishlist/verifywishlist.dart';

import '../../../../di/components/service_locator.dart';
import '../../../../models/OrderOnlineResponse.dart';
import '../../../../models/address/add_address_request.dart';
import '../../../../models/cart/CartRequest.dart';
import '../../../../models/cart/CartResponse.dart';
import '../../../../models/categories/category.dart';
import '../../../../models/categoriesbyname/categorieItems.dart';
import '../../../../models/coupan/coupon_response.dart';
import '../../../../models/feature/feature_productes.dart';
import '../../../../models/gift/gift_response.dart';
import '../../../../models/login/OtpVerifyRequest.dart';
import '../../../../models/login/RequestOtpResponse.dart';
import '../../../../models/login/login_requst.dart';
import '../../../../models/login/login_response.dart';
import '../../../../models/my_order/my_order_response.dart';
import '../../../../models/my_order/pincoderesponse.dart';
import '../../../../models/register/RegistrationRequest.dart';
import '../../../../models/wishlist/toggle_wishList_request.dart';
import '../../../../models/wishlist/wish_list_response.dart';
import '../../../sharedpref/shared_preference_helper.dart';
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
      final categoryGroupResponse = await _dioClient.get(Endpoints.getHomePageBanner);

      return BannerList.fromJson(categoryGroupResponse);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<CategoryList> getCategoryGroup() async {
    try {
      final categoryGroupResponse =
          await _dioClient.get(Endpoints.getCategoryGroup);

      return CategoryList.fromJson(categoryGroupResponse);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<FeatureProductList> getFeatureProductList() async {
    try {
      final featureProductResponse =
          await _dioClient.get(Endpoints.getFeatureProductList);

      return FeatureProductList.fromJson(featureProductResponse);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<CategorieItems> getCategoryProductListByName(String url) async {
    try {
      final viewAllCategoryProductListResponse = await _dioClient.get(url);

      return CategorieItems.fromJson(viewAllCategoryProductListResponse);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<LoginResponse> doLogin(LoginRequest loginRequest) async {
    try {
      final loginResponse = await _dioClient
          .post(Endpoints.loginUsingCredentials, data: loginRequest.toJson());

      return LoginResponse.fromJson(loginResponse);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<RequestOtpResponse> getOtp(
      String number, int toggleLoginOrNewRegister) async {
    try {
      if (toggleLoginOrNewRegister == 0) {
        debugPrint(Endpoints.loginWithPhoneNumber);

        debugPrint(toJson1(number).toString());

        final requestOtpResponse = await _dioClient
            .post(Endpoints.loginWithPhoneNumber, data: toJson1(number));

        return RequestOtpResponse.fromJson(requestOtpResponse);
      } else if (toggleLoginOrNewRegister == 1) {
        debugPrint(Endpoints.registerNewPhoneNumber);

        debugPrint(toJson1(number).toString());

        final requestOtpResponse = await _dioClient
            .post(Endpoints.registerNewPhoneNumber, data: toJson1(number));

        return RequestOtpResponse.fromJson(requestOtpResponse);
      } else {
        debugPrint(Endpoints.getForgotPasswordOtp);

        debugPrint(toJson1(number).toString());

        final requestOtpResponse = await _dioClient
            .post(Endpoints.getForgotPasswordOtp, data: toJson1(number));

        return RequestOtpResponse.fromJson(requestOtpResponse);
      }
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<LoginResponse> verifyOtp(OtpVerifyRequest otpVerifyRequest) async {
    try {
      debugPrint(Endpoints.verifyLoginWithPhoneNumberOtp);

      debugPrint(otpVerifyRequest.toJson().toString());

      final loginResponse = await _dioClient.post(
          Endpoints.verifyLoginWithPhoneNumberOtp,
          data: otpVerifyRequest.toJson());

      return LoginResponse.fromJson(loginResponse);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<LoginResponse> verifyRegisterOtp(
      RegistrationRequest registrationRequest) async {
    try {
      debugPrint(Endpoints.verifyNewRegisterWithOtp);

      debugPrint(registrationRequest.toJson().toString());

      final loginResponse = await _dioClient.post(
          Endpoints.verifyNewRegisterWithOtp,
          data: registrationRequest.toJson());

      return LoginResponse.fromJson(loginResponse);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<WishListResponse> updateProfile(String token, String firstName, String lastName,String gender,) async {
    try {
      debugPrint(Endpoints.updateProfile);
      final data = <String, String>{};
      data['firstName'] = firstName;
      data['lastName'] = lastName;
      data['gender'] = gender;

      final response = await _dioClient.post(
        Endpoints.updateProfile,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );
      return WishListResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<String> changePassword(String token, String password, String passwordConfirmation) async {
    try {
      debugPrint(Endpoints.changePassword);
      final data = <String, String>{};
      data['password'] = password;
      data['passwordConfirmation'] = passwordConfirmation;


      final response = await _dioClient.post(
        Endpoints.changePassword,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );
      return response.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<void> toggleWishList(
      ToggleWishListRequest toggleWishListRequest) async {
    try {
      debugPrint(Endpoints.toggleWishList);

      debugPrint(toggleWishListRequest.toJson().toString());

      //  final loginResponse = await _dioClient.post(Endpoints.toggleWishList, data: toggleWishListRequest.toJson());
      SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
      // getting token
      var token = await sharedPreferenceHelper.authToken;

      final response = await _dioClient.post(Endpoints.toggleWishList,
          data: toggleWishListRequest.toJson(),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      Map<String, dynamic> json = response;
      debugPrint(json.toString());

    } catch (e) {
      debugPrint(e.toString());
      // throw e;
    }
  }

  Future<WishListResponse> getWishList(String token) async {
    try {
      debugPrint(Endpoints.toggleWishList);
      final response = await _dioClient.get(Endpoints.toggleWishList,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      return WishListResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<VerifyWishlist> verifyWishList(String token) async {
    try {
      debugPrint(Endpoints.verifyWishList);

      final response = await _dioClient.get(Endpoints.verifyWishList,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      debugPrint(response.toString());
      return VerifyWishlist.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());

      throw e;
    }
  }

  Future<CartResponse> getCartList(String token) async {
    try {
      debugPrint(Endpoints.getCartList);
      final response = await _dioClient.get(Endpoints.getCartList,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      return CartResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
  Future<CartResponse> addToCart(String token) async {
    try {
      debugPrint(Endpoints.getCartList);
      final data = <String, String>{};
      //data['couponCode'] = couponCode;
      //data['orderId'] = orderId;

      final response = await _dioClient.put(Endpoints.getCartList,
          options: Options(headers: {"Content-Type": "application/json", "Authorization": "Bearer $token",}),
          data: data
      );

      return CartResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<CartResponse> addUpdateDeleteCart(String token, CartRequest cartRequest) async {
    try {
      debugPrint(Endpoints.getCartList);

      var request = CartRequest(action: cartRequest.action, items: cartRequest.items);

      final response = await _dioClient.put(
        Endpoints.getCartList,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: request.toJson(),
      );

      return CartResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<String> addCustomerAddress(
      String token, AddAddressRequest addressRequest) async {
    try {
      debugPrint(Endpoints.addAddress);

      final response = await _dioClient.post(
        Endpoints.addAddress,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: addressRequest.toJson(),
      );

      return response.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<CouponResponse> getCouPanList(String token) async {
    try {
      debugPrint(Endpoints.applyCoupon);
      final response = await _dioClient.get(Endpoints.applyCoupon,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      return CouponResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }
  Future<MyOrderResponse> getMyOrders(String token) async {
    try {
      debugPrint(Endpoints.applyCoupon);
      final response = await _dioClient.get(Endpoints.getMyOrder,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      return MyOrderResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<GiftResponse> getMyGift(String token) async {
    try {
      debugPrint(Endpoints.orderGift);
      final response = await _dioClient.get(Endpoints.orderGift,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      return GiftResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<String> getMyWallet(String token) async {
    try {
      debugPrint(Endpoints.orderGift);
      final response = await _dioClient.get(Endpoints.wallet,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));

      var walletBalance = response['walletBalance'];

      return walletBalance.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }


  Future<CartResponse> applyCoupon(String token, String couponCode, String orderId) async {
    try {
      debugPrint(Endpoints.applyCoupon);

      final data = <String, String>{};
      data['couponCode'] = couponCode;
      data['orderId'] = orderId;

      final response = await _dioClient.post(
        Endpoints.applyCoupon,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );

      return CartResponse.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<String> updateGift(String token, String id, String deliveryAddress, String claimType, ) async {
    try {


      final data = <String, String>{};
      data['id'] = id;
      data['deliveryAddress'] = deliveryAddress;
      data['claimType'] = claimType;

      debugPrint(Endpoints.giftUpdate);
      debugPrint(data.toString());

      final response = await _dioClient.post(
        Endpoints.giftUpdate,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );

      return response.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }


  Future<OrderOtpVerifyRequest> makeAnOrder(String token, String id, String deliveryAddress, String paymentType, bool canUseWallet,) async {
    try {
      final data = <String, dynamic>{};
      data['id'] = id;
      data['deliveryAddress'] = deliveryAddress;
      data['paymentType'] = paymentType;
      data['canUseWallet'] = canUseWallet;

      String gfg1 = Endpoints.makeOrder;
      String gfg2 = id;
      var url = gfg1 + gfg2;
      debugPrint(url);

      final response = await _dioClient.put(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );

      var paymentTypeRes = response['orderData']['paymentType'];
      var requestId = "";
      var key = "";
      var orderId = "";
      dynamic isFullWalletPay = false;


      if (response['otpData'] != null) {
        requestId = response['otpData']['requestId'];
      }

      if (response['paymentData'] != null) {
        key = response['paymentData']['paymentResponse']['key'];
        orderId = response['paymentData']['paymentResponse']['id'];
        isFullWalletPay = response['paymentData']['isFullWalletPay'];
      }

      return  OrderOtpVerifyRequest(paymentTypeRes: paymentTypeRes, requestId: requestId, key: key, orderId: orderId, isFullWalletPay: isFullWalletPay );

    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }

  }


  Future<OrderOtpVerifyRequest> eventPayment( Map<String, dynamic> studentEventRequest) async {
    try {

      String url = Endpoints.eventPayment;
      debugPrint(url);

      debugPrint('testevent ${studentEventRequest.toString()}');

      SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
      // getting token
      var token = await sharedPreferenceHelper.authToken;

      final response = await _dioClient.post(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: studentEventRequest,
      );

      var paymentTypeRes = response['paymentData']['paymentType'];
      var requestId = "";
      var key = "";
      var orderId = "";

      if (response['paymentData'] != null) {
        key = response['paymentData']['paymentResponse']['key'];
        orderId = response['paymentData']['paymentResponse']['id'];
      }

      return  OrderOtpVerifyRequest(paymentTypeRes: paymentTypeRes, requestId: requestId, key: key, orderId: orderId, isFullWalletPay: false);

    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }

  }


  Future<String> savePaymentSuccess(String token, String orderId, String paymentId, String signature) async {
    try {
      final data = <String, String>{};
      data['razorpay_order_id'] = orderId;
      data['razorpay_payment_id'] = paymentId;
      data['razorpay_signature'] = signature;

      debugPrint(Endpoints.savePaymentSuccess);
      final response = await _dioClient.post(
        Endpoints.savePaymentSuccess,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );

      return  response.toString();

    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }

  }
  Future<String> savePaymentSuccessEvent(String token, String orderId, String paymentId, String signature) async {
    try {
      final data = <String, String>{};
      data['razorpay_order_id'] = orderId;
      data['razorpay_payment_id'] = paymentId;
      data['razorpay_signature'] = signature;

      debugPrint(Endpoints.savePaymentSuccessEvent);
      final response = await _dioClient.post(
        Endpoints.savePaymentSuccessEvent,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );

      return  response.toString();

    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }

  }


  Future<String> getOrderInit(String token) async {
    try {
      debugPrint(Endpoints.getOrderInit);
      final response = await _dioClient.post(Endpoints.getOrderInit,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }),
          data: {});

      var status = response['status'];
      var message = response['message'];
      var walletBalance = response['walletBalance'];
      var orderId = response['orderData']['orderId'];
      debugPrint(orderId.toString());

      return orderId+":"+walletBalance.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }

  Future<String> verifyOtpOrder(
      String token, String otp, String requestId, String id) async {
    try {
      debugPrint(Endpoints.verifyOtp);

      final data = <String, String>{};
      data['otp'] = otp;
      data['requestId'] = requestId;
      data['id'] = id;

      final response = await _dioClient.post(
        Endpoints.verifyOtp,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
        data: data,
      );

      debugPrint(response.toString());

      return response.toString();
    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }
  }


  Future<PincodeResponse> checkPinCode(String pincode, ) async {
    try {

      String gfg1 = Endpoints.pincode;
      String gfg2 = pincode;
      var url = gfg1 + gfg2;
      debugPrint(url);

      final response = await _dioClient.get(
        url,
        options: Options(headers: {
          "Content-Type": "application/json",

        }),

      );

      return  PincodeResponse.fromJson(response);

    } catch (e) {
      debugPrint(e.toString());
      throw e;
    }

  }

  Map<String, String> toJson1(String loginid) {
    final data = <String, String>{};
    data['mobileNo'] = loginid;
    return data;
  }
}
