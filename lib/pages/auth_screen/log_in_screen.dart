import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/models/login/login_response.dart';
import 'package:shopeein/pages/auth_screen/sign_up.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../data/repository/login_repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/login/RequestOtpResponse.dart';
import '../../models/login/login_requst.dart';
import '../../models/register/request_otp.dart';
import '../../utils/device/custom_error.dart';
import '../../widgets/buttons.dart';
import '../../widgets/error_dialog.dart';
import '../initial_page.dart';
import 'forgot_pass_screen.dart';
import 'otp_auth_screen.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = "/LogInScreen";

  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool _isLoading = false; //bool variable created
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    otpController.dispose();
    super.dispose();
  }

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
                        key: formKey, //key for form
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Phone Number or Email',
                                hintText:
                                    'Please Enter Your Email or Phone Number',
                              ),
                              validator: (value) {
                                if (value != null) {
                                  if (!RegExp(
                                          r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                      .hasMatch(value)) {
                                    if (!RegExp(
                                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return "Enter Correct Email or Phone";
                                    } else {
                                      return null;
                                    }
                                  } else {
                                    return null;
                                  }
                                } else {
                                  return " Enter Correct Email or Phone is empty ";
                                }
                              },
                              controller: userNameController,
                            ),
                            const SizedBox(height: 20),
                            AppTextField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                                hintText: 'Please Enter Your Password',
                              ),
                              textFieldType: TextFieldType.PASSWORD,
                              validator: (value) => value!.length < 6
                                  ? 'Password too short.'
                                  : null,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                               /* Row(
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
                                ),*/
                                TextButton(
                                  onPressed: () {
                                    //const ForgotPassScreen().launch(context);
                                    _displayTextInputDialog(
                                        context, "Forgot Password", 2);
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
                                if (formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final username =
                                      userNameController.value.text;
                                  final password =
                                      passwordController.value.text;
                                  LoginRequest loginRequest = LoginRequest(
                                      loginId: username, password: password);
                                  _loginWithCredentials(loginRequest, context);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                MyGoogleText(
                                  fontSize: 16,
                                  fontColor: textColors,
                                  text: 'OR',
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Button1(
                              buttonText: 'SingIn With Otp',
                              buttonColor: primaryColor,
                              onPressFunction: () {
                                _displayTextInputDialog(
                                    context, "Login with opt", 0);
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
                                    _displayTextInputDialog(
                                        context, "Register", 1);
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
                      )),
                ],
              )
            : loader());
  }

  Widget loader() {
    return const Center(child: CircularProgressIndicator());
  }

  Future<void> _displayTextInputDialog(BuildContext context, String title, int toggleLoginOrNewRegister) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: otpController,
              //controller: _textFieldController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
                hintText: 'Please Enter Your Phone Number',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const MyGoogleText(
                  text: 'Cancel',
                  fontSize: 16,
                  fontColor: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () {
                  final value = otpController.value.text;
                  if (RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)) {
                    Navigator.pop(context);
                    setState(() {
                      _isLoading = true;
                    });
                    verifyLoginOrRegisterByOtp(value, context, toggleLoginOrNewRegister);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Your number is not valid",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: const MyGoogleText(
                  text: 'Ok',
                  fontSize: 16,
                  fontColor: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        });
  }

  FutureOr<void> _loginWithCredentials(

      LoginRequest loginRequest, BuildContext buildContext) async {
    try {
      final LoginRepository loginRepository = getIt<LoginRepository>();

      final LoginResponse response = await loginRepository.loginWithCredential(loginRequest);

      debugPrint(response.user.token);

      setState(() {
        _isLoading = false;
      });

      Fluttertoast.showToast(
          msg: "Login Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      navigateLogin();

    } on CustomError catch (e) {
      setState(() {
        _isLoading = false;
      });
      errorDialog(buildContext, e.errMsg);
    }
  }

  void navigateLogin() {

    Navigator.pop(context);

  }

  FutureOr<void> verifyLoginOrRegisterByOtp(String phone,
      BuildContext buildContext, int toggleLoginOrNewRegister) async {
    try {

      final LoginRepository loginRepository = getIt<LoginRepository>();

      final RequestOtpResponse response = await loginRepository.loginWithPhoneNumber(phone, toggleLoginOrNewRegister);

      setState(() {
        _isLoading = false;
      });

      final res = RequestOtp(
        toggleLoginOrNewRegister: toggleLoginOrNewRegister,
        otp: '',
        requestOtpResponse: response,
      );

      navigateToOtpScreen(res);

    } on CustomError catch (e) {

      setState(() {
        _isLoading = false;
      });

      errorDialog(context, e.errMsg);
    }
  }

  void navigateToOtpScreen(RequestOtp response) {
    Navigator.pushNamed(context, OtpAuthScreen.routeName, arguments: response);
  }
}
