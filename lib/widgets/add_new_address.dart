import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../constants/constants.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
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
              ),

              const SizedBox(height: 15),

              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name*',
                  hintText: 'Enter Your First Name',
                ),
              ),


              const SizedBox(height: 15),

              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name*',
                  hintText: 'Enter Your Last Name',
                ),
              ),


              const SizedBox(height: 15),

              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number*',
                  hintText: 'Enter Your phone number',
                ),
              ),

              const SizedBox(height: 15),

              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Street address*',
                  hintText: 'Enter Your Street address',
                ),
              ),

              const SizedBox(height: 15),

              Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Town / City*',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Postcode*',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'State*',
                  hintText: 'Enter Your State',
                ),
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
                        onPressed: () {
                        },
                        child: const MyGoogleText(
                          text: '',
                          fontSize: 16,
                          fontColor: secondaryColor1,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                      )
                    ],
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
                  onPressFunction: () {}),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),

    );
  }
}
