import 'dart:async';

import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../data/repository/login_repository.dart';
import '../../di/components/service_locator.dart';

import '../../widgets/buttons.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../widgets/error_dialog.dart';
import '../data/exceptions/network_exceptions.dart';
import '../models/wishlist/verifywishlist.dart';
import '../models/wishlist/wish_list_response.dart';


class MyProfileScreen extends StatefulWidget {
  static const String routeName = "/MyProfileScreen";

  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreen();
}

class _MyProfileScreen extends State<MyProfileScreen> {
  bool _isLoading = false;

  //bool variable created
  bool isChecked = false;

  var userFirstNameController = TextEditingController();
  var userLastNameController = TextEditingController();
  var passwordController = TextEditingController();

  String _verticalGroupValue = "Male";
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
    Profile profile = ModalRoute.of(context)!.settings.arguments as Profile;

    if (profile.gender?.isEmpty ?? true) {
      _verticalGroupValue = "Male";
    } else {
      if (profile.gender == "Female") {

        _verticalGroupValue = "Female";
      } else if (profile.gender == "Male") {
        _verticalGroupValue = "Male";
      } else {
        _verticalGroupValue = "Other";
      }
    }

    // _verticalGroupValue = profile.gender ?? 'Male' ;
    userFirstNameController.text = profile.firstName ?? '';
    userLastNameController.text = profile.lastName ?? '';
    passwordController.text = profile.mobileNo ?? '';

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
            text: 'Edit Profile',
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
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                              hintText: 'Please Enter Your First Name',
                            ),
                            validator: (value) => value!.length < 2
                                ? 'First name is not valid.'
                                : null,
                            controller: userFirstNameController,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name',
                              hintText: 'Please Enter Your Last Name',
                            ),
                            validator: (value) => value!.length < 2
                                ? 'Last name is not valid.'
                                : null,
                            controller: userLastNameController,
                          ),
                          const SizedBox(height: 20),
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            activeColor: primaryColor,
                            onChanged: (value) => setState(() {
                              profile.gender = value ;
                              _verticalGroupValue = value!;

                            }),
                            items: _status,
                            textStyle: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Button1(
                            buttonText: 'Update Profile',
                            buttonColor: primaryColor,
                            onPressFunction: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                final firstName =
                                    userFirstNameController.value.text;
                                final lastName =
                                    userLastNameController.value.text;
                                final password = passwordController.value.text;
                                updateProfile(
                                    firstName, lastName, _verticalGroupValue);
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



  FutureOr<void> updateProfile(
    String firstName,
    String lastName,
    String gender,
  ) async {
    try {
      final LoginRepository loginRepository = getIt<LoginRepository>();

      final WishListResponse response =
          await loginRepository.updateProfile(firstName, lastName, gender);

      Fluttertoast.showToast(
          msg: "Profile updated successfully",
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
    }catch (e) {
      if (e is CustomException) {
        setState(() {
          _isLoading = false;
        });
        errorDialog(context, e.message);
      } else {
        debugPrint(e.toString());
      }
    }

  }

  void navigateToOtpScreen() {
    Navigator.of(context).pop();
  }

  Widget loader() {
    return const Center(child: CircularProgressIndicator());
  }
}
