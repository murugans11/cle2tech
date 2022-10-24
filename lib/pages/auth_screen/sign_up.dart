import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../widgets/buttons.dart';
import '../../widgets/social_media_button.dart';
import 'log_in_screen.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "/SignUp";

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
          text: 'Sign Up',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 110,
            width: 110,
            child: Image(
              image: AssetImage(
                AppTheme.of(context)?.assets.logo1 ?? '',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
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
                    labelText: 'Full Name',
                    hintText: 'Enter Your Full Name',
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                Button1(
                  buttonText: 'Sign Up',
                  buttonColor: primaryColor, onPressFunction: null,
                  // onPressFunction: () => const WelComeScreen().launch(context),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyGoogleText(
                      fontSize: 16,
                      fontColor: textColors,
                      text: 'Already have an account?',
                      fontWeight: FontWeight.w500,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const MyGoogleText(
                        text: 'Sign In',
                        fontSize: 16,
                        fontColor: secondaryColor1,
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
