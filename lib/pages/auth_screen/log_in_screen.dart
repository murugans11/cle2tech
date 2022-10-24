import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/auth_screen/sign_up.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../widgets/buttons.dart';
import '../../widgets/social_media_button.dart';
import 'forgot_pass_screen.dart';
import 'otp_auth_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = "/LogInScreen";

  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
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
        title: const MyGoogleText(
          text: 'Login',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          SizedBox(
            height: 110,
            width: 110,
            child: Image(
              image: AssetImage(
                AppTheme.of(context)?.assets.logo1 ?? '',
              ),
            ),
          ),
          const SizedBox(height: 10,),
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
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: TextEditingController(), // Optional
                  textFieldType: TextFieldType.PASSWORD,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: secondaryColor1,
                          checkColor: black,
                          //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const MyGoogleText(
                          text: 'Remember me',
                          fontColor: textColors,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        const ForgotPassScreen().launch(context);
                      },
                      child: const MyGoogleText(
                        text: 'Forgot Password',
                        fontColor: textColors,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Button1(
                  buttonText: 'Sign In',
                  buttonColor: primaryColor,
                  onPressFunction: () {
                    //const WelComeScreen().launch(context);
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyGoogleText(
                      fontSize: 16,
                      fontColor: textColors,
                      text: 'Not a member?',
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, OtpAuthScreen.routeName);
                      },
                      child: const MyGoogleText(
                        text: 'Join now',
                        fontSize: 16,
                        fontColor: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
