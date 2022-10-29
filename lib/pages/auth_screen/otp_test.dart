import 'dart:async';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/repository/login_repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/login/OtpVerifyRequest.dart';
import '../../models/login/RequestOtpResponse.dart';
import '../../models/login/login_response.dart';
import '../../utils/device/custom_error.dart';
import '../../widgets/error_dialog.dart';

class OtpForm extends StatefulWidget {
  final RequestOtpResponse requestOtpResponse;

  const OtpForm({Key? key, required this.requestOtpResponse}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool _isLoading = false;

  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;
  late FocusNode pin6FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var buffer = StringBuffer();

    return !_isLoading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 50.0,
                    child: TextFormField(
                      autofocus: true,
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        buffer.write(value);
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: TextFormField(
                        focusNode: pin2FocusNode,
                        obscureText: true,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) => {
                              buffer.write(value),
                              nextField(value, pin3FocusNode),
                            }),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: TextFormField(
                      focusNode: pin3FocusNode,
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) => {
                        buffer.write(value),
                        nextField(value, pin4FocusNode)
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: TextFormField(
                        focusNode: pin4FocusNode,
                        obscureText: true,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) => {
                              buffer.write(value),
                              nextField(value, pin5FocusNode),
                            }),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: TextFormField(
                        focusNode: pin5FocusNode,
                        obscureText: true,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) => {
                              buffer.write(value),
                              nextField(value, pin6FocusNode),
                            }),
                  ),
                  SizedBox(
                    width: 50.0,
                    child: TextFormField(
                      focusNode: pin6FocusNode,
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        if (value.length == 1) {
                          buffer.write(value);
                          pin6FocusNode.unfocus();

                          var request = OtpVerifyRequest(
                              loginId: widget.requestOtpResponse.data.phone,
                              otp: buffer.toString(),
                              requestId: widget.requestOtpResponse.data.requestId);
                          _fetchLoginOtpResponse(request, context);
                          // Then you need to check is the code is correct or not
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        : loader();
  }

  FutureOr<void> _fetchLoginOtpResponse(
      OtpVerifyRequest otpVerifyRequest, BuildContext buildContext) async {
    try {
      final LoginRepository loginRepository = getIt<LoginRepository>();

      final LoginResponse response = await loginRepository.loginWithOTPStep2(otpVerifyRequest);

      setState(() {
        _isLoading = false;
      });

      debugPrint(response.user.token);

    } on CustomError catch (e) {
      setState(() {
        _isLoading = false;
      });
      errorDialog(buildContext, e.errMsg);
    }
  }

  Widget loader() {
    return const Center(child: CircularProgressIndicator());
  }
}
