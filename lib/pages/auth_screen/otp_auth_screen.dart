import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/register/request_otp.dart';
import 'otp_test.dart';

class OtpAuthScreen extends StatefulWidget {

  static const String routeName = "/OtpAuthScreen";

  const OtpAuthScreen({Key? key}) : super(key: key);

  @override
  State<OtpAuthScreen> createState() => _OtpAuthScreenState();
}

class _OtpAuthScreenState extends State<OtpAuthScreen> {
  @override
  Widget build(BuildContext context) {
    RequestOtp requestOtpResponse = ModalRoute.of(context)!.settings.arguments as RequestOtp;

    String phone = requestOtpResponse.requestOtpResponse.data.phone;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 30),
            child: SizedBox(
              height: 100,
              width: 248,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MyGoogleText(
                    fontSize: 26,
                    fontColor: Colors.black,
                    text: 'OTP Authentication',
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 15),
                  MyGoogleText(
                    fontSize: 16,
                    fontColor: textColors,
                    text: 'Please enter the 6-digit code sent to:$phone',
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
          //const Spacer(),
          Container(
            padding: const EdgeInsets.all(30),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                OtpForm(
                  requestOtpResponse: requestOtpResponse,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyGoogleText(
                      fontSize: 16,
                      fontColor: textColors,
                      // text: 'Code send in 0:29',
                      text: 'Code sent',
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const MyGoogleText(
                        text: ' Resend code',
                        fontSize: 16,
                        fontColor: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),

                /*const SizedBox(height: 20),
                Button1(
                    buttonText: 'Continue',
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      //const ChangePassScreen().launch(context);
                      Navigator.pushNamed(context, SignUp.routeName);
                    }),*/

                const SizedBox(height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
