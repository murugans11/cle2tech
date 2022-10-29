import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../models/login/RequestOtpResponse.dart';
import '../../widgets/buttons.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "/SignUp";

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isChecked = false;
  String _verticalGroupValue = "Male";
  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final List<String> _status = ["Male", "Female", "Other"];

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    RequestOtpResponse requestOtpResponse = ModalRoute.of(context)!.settings.arguments as RequestOtpResponse;

    final formKey = GlobalKey<FormState>();
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
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(AppTheme.of(context)?.assets.logo1 ?? ''),
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
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[

                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      hintText: 'Please Enter Your First Name',
                    ),
                    validator: (value) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                        return "Please Enter Your First Name";
                      }
                      return null;
                    },
                    controller: userFirstNameController,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      hintText: 'Please Enter Your First Name',
                    ),
                    validator: (value) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                        return "Please Enter Your Last Name";
                      }
                      return null;
                    },
                    controller: userLastNameController,
                  ),
                  const SizedBox(height: 20),

                  AppTextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Please Enter Your Password',
                    ),
                    textFieldType: TextFieldType.PASSWORD,
                    validator: (value) =>
                        value!.length < 6 ? 'Password too short.' : null,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),

                  RadioGroup<String>.builder(
                    direction: Axis.horizontal,
                    groupValue: _verticalGroupValue,
                    horizontalAlignment: MainAxisAlignment.spaceAround,
                    activeColor: primaryColor,
                    onChanged: (value) => setState(() {
                      _verticalGroupValue = value!;
                    }),
                    items: _status,
                    textStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                    itemBuilder: (item) => RadioButtonBuilder(item,),
                  ),
                  const SizedBox(height: 20),

                  Button1(
                    buttonText: 'Sign Up',
                    buttonColor: primaryColor,
                     onPressFunction: () => {

                     },
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
                          // Navigator.of(context)..pop()..pop()..pop();
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
          ),
        ],
      ),
    );
  }
}
