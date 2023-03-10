import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../device/custom_error.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static String handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          switch (error.response?.statusCode) {
            case 400:{
                try {
                  Map errorData = error.response?.data;

                  if ( errorData['errorData'].isNotEmpty) {
                    errorDescription = "${error.response?.data['errorData']['msg']}";
                  }else{
                    errorDescription = "${error.response?.data['errors'][0]['msg']}";
                  }

                } catch (e) {
                  debugPrint(e.toString());
                  throw CustomError(errMsg: errorDescription = e.toString());

                }
              }
              break;
            case 401:{
                try {
                  errorDescription = "${error.response?.data['message']}";
                } catch (e) {
                  debugPrint(e.toString());
                  errorDescription = e.toString();
                }
              }
          }
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
