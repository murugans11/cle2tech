import 'package:flutter/material.dart'hide ModalBottomSheetRoute;

import 'package:nb_utils/nb_utils.dart';

import '../../constants/constants.dart';
import '../../widgets/buttons.dart';
import 'otp_auth_screen.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
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
        /*title: const MyGoogleText(
          text: 'Login',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),*/
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
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
                children: const [
                  MyGoogleText(
                    fontSize: 26,
                    fontColor: Colors.black,
                    text: 'Forgot Password',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 15),
                  MyGoogleText(
                    fontSize: 16,
                    fontColor: textColors,
                    text: 'Enter your email below to receive your password',
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
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
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                const SizedBox(height: 30),
                Button1(
                    buttonText: 'Send New Password',
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      const OtpAuthScreen().launch(context);
                    }),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
