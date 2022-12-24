import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:nb_utils/nb_utils.dart';
import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/address/add_address_request.dart';
import 'buttons.dart';

class AddNewAddress extends StatefulWidget {
  const AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {

  bool addressSwitch = false;
  String _verticalGroupValue = "Home";
  final List<String> _status = ["Home", "Work"];

  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final localityController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateCodeController = TextEditingController();

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    localityController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    stateCodeController.dispose();
    super.dispose();
  }

  Future<void> _getLatest(AddAddressRequest addressRequest) async {
    _loadingIndicator();
    SharedPreferenceHelper sharedPreferenceHelper =
        getIt<SharedPreferenceHelper>();
    HomeRepository homeRepository = getIt<HomeRepository>();
    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      await homeRepository.addCustomerAddress(token, addressRequest);
      setState(() {
        Navigator.of(context).pop('save');
      });
    }
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();

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
          text: 'Shipping Address',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyGoogleText(
                      text: 'Add New Address',
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),*/

                const SizedBox(height: 15),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                    hintText: 'Please Enter Your First Name',
                  ),
                  validator: (value) =>
                      value!.length < 2 ? 'First name is not valid.' : null,
                  controller: userFirstNameController,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                    hintText: 'Please Enter Your Last Name',
                  ),
                  validator: (value) =>
                      value!.length < 2 ? 'Last name is not valid.' : null,
                  controller: userLastNameController,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number*',
                    hintText: 'Enter Your phone number',
                  ),
                  validator: (value) =>
                      value!.length < 6 ? 'phone number is not valid.' : null,
                  controller: phoneNumberController,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Street address*',
                    hintText: 'Enter Your Street address',
                  ),
                  validator: (value) =>
                      value!.length < 8 ? 'Street address.' : null,
                  controller: addressController,
                ),

                const SizedBox(height: 15),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Locality',
                    hintText: 'Enter Your Locality',
                  ),
                  validator: (value) => value!.length < 2 ? 'Locality .' : null,
                  controller: localityController,
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Town / City*',
                          hintText: 'Enter Your Town / City',
                        ),
                        validator: (value) =>
                            value!.length < 2 ? 'Town / City .' : null,
                        controller: cityController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      /*child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Postcode*',
                        ),
                      ),*/
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Postcode*',
                          hintText: 'Enter Your Postcode',
                        ),
                        validator: (value) =>
                            value!.length < 6 ? 'Postcode .' : null,
                        controller: pinCodeController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'State*',
                    hintText: 'Enter Your State',
                  ),
                  validator: (value) =>
                      value!.length < 2 ? 'Enter Your State .' : null,
                  controller: stateCodeController,
                ),

                ///Address Type______________________________
                const SizedBox(height: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            MyGoogleText(
                              text: 'Address Type',
                              fontSize: 18,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.check_circle,
                              color: primaryColor,
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const MyGoogleText(
                            text: '',
                            fontSize: 16,
                            fontColor: secondaryColor1,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),

                    RadioGroup<String>.builder(
                      direction: Axis.horizontal,
                      groupValue: _verticalGroupValue,
                      horizontalAlignment:
                      MainAxisAlignment.spaceAround,
                      activeColor: primaryColor,
                      onChanged: (value) => setState(() {
                        _verticalGroupValue = value!;
                      }),
                      items: _status,
                      textStyle: const TextStyle(
                          fontSize: 15, color: Colors.grey),
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const MyGoogleText(
                      text: 'Use as Billing address',
                      fontSize: 18,
                      fontColor: textColors,
                      fontWeight: FontWeight.normal,
                    ),
                    Platform.isAndroid
                        ? Switch(
                            value: addressSwitch,
                            onChanged: (value) {
                              setState(() {
                                addressSwitch = value;
                              });
                            },
                            activeColor: secondaryColor1,
                          )
                        : CupertinoSwitch(
                            activeColor: secondaryColor1,
                            value: addressSwitch,
                            onChanged: (value) {
                              setState(() {
                                addressSwitch = value;
                              });
                            },
                          )
                  ],
                ),

                const SizedBox(height: 15),

                Button1(
                    buttonText: 'Save',
                    buttonColor: primaryColor,
                    onPressFunction: () {
                      if (formKey.currentState!.validate()) {
                        final firstName = userFirstNameController.value.text;
                        final lastName = userLastNameController.value.text;
                        final phone = phoneNumberController.value.text;
                        final address = addressController.value.text;
                        final locality = localityController.value.text;
                        final city = cityController.value.text;
                        final pinCode = pinCodeController.value.text;
                        final state = stateCodeController.value.text;
                        var request = AddAddressRequest(
                            firstName: firstName,
                            lastName: lastName,
                            mobileNo: phone,
                            pincode: pinCode,
                            locality: locality,
                            address: address,
                            city: city,
                            state: state,
                            addressType: _verticalGroupValue,
                            isPrimary: addressSwitch);
                        _getLatest(request);
                      }
                    }),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
