import 'dart:async';

import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:nb_utils/nb_utils.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../data/repository/login_repository.dart';
import '../../di/components/service_locator.dart';

import '../../utils/device/custom_error.dart';
import '../../widgets/buttons.dart';

import '../../widgets/error_dialog.dart';

class ChangePassScreen extends StatefulWidget {
  static const String routeName = "/ChangePassScreen";

  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  State<ChangePassScreen> createState() => _ChangePassScreen();
}

class _ChangePassScreen extends State<ChangePassScreen> {
  bool _isLoading = false;
  var password = TextEditingController();
  var conformPassword = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    conformPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            text: 'Change Password',
            fontColor: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
        body: !_isLoading
            ? Column(
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
                        image: AssetImage(
                            AppTheme.of(context)?.assets.logo1 ?? ''),
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
                          const SizedBox(height: 10),
                          AppTextField(
                            controller: password, // Optional
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 15),
                          AppTextField(
                            controller: conformPassword, // Optional
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(height: 20),
                          const MyGoogleText(
                              text: 'Must Contain 8 Characters,',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal),
                          const SizedBox(height: 5),
                          const MyGoogleText(
                              text: 'Minimum One Uppercase',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal),
                          const SizedBox(height: 5),
                          const MyGoogleText(
                              text: 'Minimum One Lowercase',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal),
                          const SizedBox(height: 5),
                          const MyGoogleText(
                              text: 'Minimum One Number ',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal),
                          const SizedBox(height: 5),
                          const MyGoogleText(
                              text: 'Minimum One Special Case Character ',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal),
                          const SizedBox(height: 20),
                          Button1(
                            buttonText: 'Submit',
                            buttonColor: primaryColor,
                            onPressFunction: () {
                              if (formKey.currentState!.validate()) {
                                final pw = password.value.text;
                                final cp = conformPassword.value.text;
                                if (pw != cp) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Password and confirm password is not matched!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  if (!validateStructure(pw)) {
                                    Fluttertoast.showToast(
                                        msg: "Password is not valid!",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    changePassword(
                                      pw,
                                      cp,
                                    );
                                  }
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : loader());
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  FutureOr<void> changePassword(String password, String conformPassword) async {
    try {
      final LoginRepository loginRepository = getIt<LoginRepository>();

      final String response =
          await loginRepository.changePassword(password, conformPassword);

      Fluttertoast.showToast(
          msg: "Password changed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      setState(() {
        _isLoading = false;
      });

      navigateToOtpScreen();
    } on CustomError catch (e) {
      setState(() {
        _isLoading = false;
      });
      errorDialog(context, e.errMsg);
    }
  }

  void navigateToOtpScreen() {
    Navigator.of(context).pop();
  }

  Widget loader() {
    return const Center(child: CircularProgressIndicator());
  }
}
