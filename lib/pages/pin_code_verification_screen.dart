import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:pin_code_fields/pin_code_fields.dart';


import '../blocs/make_order/markorder_bloc.dart';
import '../blocs/make_order/markorder_event.dart';
import '../blocs/make_order/markorder_state.dart';
import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../di/components/service_locator.dart';
import '../models/otp_verify/OrderOtpVerifyRequest.dart';
import '../utils/dio/network_call_status_enum.dart';
import '../widgets/confirmation_popup.dart';

class PinCodeVerificationScreen extends StatefulWidget {

  static const String routeName = "/PinCodeVerificationScreen";



  const PinCodeVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  PinCodeVerificationScreenState createState() =>
      PinCodeVerificationScreenState();
}

class PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String otpText = "";

  final formKey = GlobalKey<FormState>();

  HomeRepository homeRepository = getIt<HomeRepository>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final orderOtpVerifyRequest = ModalRoute.of(context)!.settings.arguments as OrderOtpVerifyRequest;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const MyGoogleText(
          text: 'OTP Authentication',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 30),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '*',
                      /* obscuringWidget: const FlutterLogo(
                        size: 24,
                      ),*/
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeFillColor: Colors.white,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        debugPrint(value);
                        setState(() {
                          otpText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        debugPrint("Allowing to paste $text");
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<MakeOrderBloc, MakeOrderState>(
                listener: (context, state) {
                  if (state.status == NetworkCallStatusEnum.loaded) {
                    //{status: 200, success: true, message: Payment has been verified, orderGiftData: {orderGiftId: 639e02429e46977080534d88}}
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (BuildContext context, _, __) =>
                            const RedeemConfirmationScreen(
                          image: 'images/confirm_order_pupup.png',
                          mainText: 'Order successfully!',
                          subText:
                              'Your order will be delivered soon. Thank you.',
                          buttonText: 'Back to Home',
                        ),
                      ),
                    );
                  } else if (state.status == NetworkCallStatusEnum.error) {
                    Fluttertoast.showToast(
                        msg: state.error.errMsg,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                builder: (context, state) {
                  if (state.status == NetworkCallStatusEnum.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 30),
                    decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.green.shade200,
                              offset: const Offset(1, -2),
                              blurRadius: 5),
                          BoxShadow(
                              color: Colors.green.shade200,
                              offset: const Offset(-1, 2),
                              blurRadius: 5)
                        ]),
                    child: ButtonTheme(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          formKey.currentState!.validate();
                          // conditions for validating
                          if (otpText.length != 6) {
                            errorController!.add(ErrorAnimationType
                                .shake); // Triggering error shake animation
                            setState(() => hasError = true);
                          } else {
                            context.read<MakeOrderBloc>().add(
                                  MakeCODOrderOtpVerifyEvent(
                                    token: orderOtpVerifyRequest.token ,
                                    orderId: orderOtpVerifyRequest.orderId,
                                    requestId: orderOtpVerifyRequest.requestId,
                                    otp: otpText,
                                  ),
                                );
                          }
                        },
                        child: Center(
                            child: Text(
                          "VERIFY".toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
