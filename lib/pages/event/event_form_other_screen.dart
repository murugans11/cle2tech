
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../constants/app_theme.dart';
import '../../constants/constants.dart';
import '../../data/repository/home_repository.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../di/components/service_locator.dart';

import '../../widgets/confirmation_popup.dart';



class EventFormOtherScreen extends StatefulWidget {
  static const String routeName = "/EventFormOtherScreen";

  @override
  EventFormOtherScreenState createState() => EventFormOtherScreenState();
}

class EventFormOtherScreenState extends State<EventFormOtherScreen> {
  final formKey = GlobalKey<FormState>();


  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  String _verticalGroupValue = "Male";
  final List<String> _status = ["Male", "Female", "Other"];



  String _verticalGroupValue2 = "Drawing";
  final List<String> _status2 = [
    "Drawing",
    "Singing",
    "Dancing",
    "Music",
    "Quiz",
    "Others"
  ];

  // By defaut, the checkbox is unchecked and "agree" is "false"
  bool agree = false;



  final userFirstNameController = TextEditingController();
  final userLastNameController = TextEditingController();
  final userEmailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final occupationController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final pinCodeController = TextEditingController();
  final stateCodeController = TextEditingController();
  final userOtherTalentController = TextEditingController();





  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
  }


  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    userEmailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
    stateCodeController.dispose();
    occupationController.dispose();
    dobController.dispose();
    userOtherTalentController.dispose();
    super.dispose();


  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    Navigator.pop(context);
    print(response);
    var order = response.orderId;
    var paymentId = response.paymentId;
    var signature = response.signature;
    var ids = " orderid $order +paymentId $paymentId +signature $signature";
    debugPrint("payment response $ids");

    SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
    HomeRepository homeRepository = getIt<HomeRepository>();
    final tokenValues = await sharedPreferenceHelper.authToken;

    try{
      final orderInit = await homeRepository.savePaymentSuccessEvent(tokenValues ?? '', order ?? '', paymentId?? '', signature?? '');
      debugPrint(orderInit.toString());
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
          const RedeemConfirmationScreen(
            image: 'images/confirm_order_pupup.png',
            mainText: 'Payment successfully done!',
            subText:
            'Thank you.',
            buttonText: 'Back to Home',
          ),
        ),
      );
    }catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ids),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {

    Navigator.pop(context);
    // Do something when payment fails
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  // create order
  void createOrder(String key, String orderId, String contactNumber, String email) async {
    openGateway(key, orderId, contactNumber, email);
  }


  openGateway(String key, String orderId, String contactNumber, String email) {
    var options = {
      //'key': "rzp_live_MvPwKYplVlFBKd",
      'key': key,
      //'amount': 1, //in the smallest currency sub-unit.
      //'name': 'Shoppein.com',
      'order_id': orderId, // Generate order_id using Orders API
      //'description': 'Fine T-Shirt',
      // 'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': contactNumber,
        'email': email,
      }
    };
    _razorpay.open(options);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          text: 'Participant Info',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.orange)
              ),
              child: Stepper(
                type: stepperType,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[

                  Step(
                    title: const Text('Personal'),
                    content: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

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
                          const SizedBox(height: 15),

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
                          const SizedBox(height: 15),

                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email address',
                              hintText: 'Please Enter Your Email',
                            ),
                            validator: (value) {
                              final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value ?? '');
                              if (!emailValid) {
                                return 'Your Email is not valid.';
                              } else {
                                return null;
                              }
                            },
                            controller: userEmailController,
                          ),
                          const SizedBox(height: 15),

                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number*',
                              hintText: 'Enter Your phone number',
                            ),
                            validator: (value) => value!.length < 6
                                ? 'phone number is not valid.'
                                : null,
                            controller: phoneNumberController,
                          ),

                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Occupation',
                              hintText: 'Please Enter Your Occupation',
                            ),
                            validator: (value) => value!.length < 2
                                ? 'First name is not valid.'
                                : null,
                            controller: occupationController,
                          ),



                          const SizedBox(height: 15),
                          RadioGroup<String>.builder(
                            direction: Axis.horizontal,
                            groupValue: _verticalGroupValue,
                            horizontalAlignment: MainAxisAlignment.spaceAround,
                            activeColor: primaryColor,
                            onChanged: (value) => setState(() {
                              _verticalGroupValue = value!;
                            }),
                            items: _status,
                            textStyle:
                            const TextStyle(fontSize: 15, color: Colors.grey),
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),

                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'DOB',
                              hintText: 'Enter Your DOB',
                            ),
                            readOnly: true,
                            // when true user cannot edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  //get today's date
                                  firstDate: DateTime(1940),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                String formattedDate = DateFormat('dd-MM-yyyy')
                                    .format(
                                    pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                print(
                                    formattedDate); //formatted date output using intl package =>  2022-07-04
                                //You can format date as per your need

                                setState(() {
                                  dobController.text =
                                      formattedDate; //set foratted date to TextField value.
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            validator: (value) {
                              return null;
                            },
                            controller: dobController,
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
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
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

                          const SizedBox(height: 15),
                          const MyGoogleText(
                            text: 'Select your talent to participate in event',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5),

                          Wrap(children: [
                            RadioGroup<String>.builder(
                              direction: Axis.vertical,
                              groupValue: _verticalGroupValue2,
                              horizontalAlignment: MainAxisAlignment.start,
                              activeColor: primaryColor,
                              onChanged: (value) => setState(() {
                                _verticalGroupValue2 = value!;
                              }),
                              items: _status2,
                              textStyle:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                              itemBuilder: (item) => RadioButtonBuilder(
                                item,
                              ),
                            ),
                          ]),

                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mention your talent specifically',
                              hintText: 'Please enter your qualification',
                            ),
                            validator: (value) => null,
                            controller: userOtherTalentController,
                          ),

                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),


                  Step(
                    title: const Text('Fees'),
                    content: Column(
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                  AppTheme.of(context)?.assets.success_bg ?? ''),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const MyGoogleText(
                          text: 'Pay Rs:299 to Join Shopeein Talent Contest',
                          fontSize: 14,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),

                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(width: 1, color: textColors),
                            ),
                          ),
                          child: const ExpansionTile(
                            title: Text('Terms and conditions'),
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: ReadMoreText(
                                  "To Join Shopeein Talent Contest You need to pay Rs:299 as entry fees. And the entry fees Rs:299 will be added in your Shopeein Wallet. Which can be utilized for Shopping Clothes. Groceries, Accessories, beauty Products etc in Shopeein APP (Ios/Android) or www.shopeein.com. The Paid Amount Rs:299 for Contest will not be refundable. It can be Used In WWW.SHOPEEIN.COM / SHOPEEIN APP for Purchasing Purpose Only. ",
                                  trimLines: 2,
                                  colorClickableText: primaryColor,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Material(
                              child: Checkbox(
                                value: agree,
                                onChanged: (value) {
                                  setState(() {
                                    agree = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const Text(
                              'I have read and accept terms and conditions',
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),



                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() async {
    if (formKey.currentState!.validate()) {

      final firstName = userFirstNameController.value.text;
      final lastName = userLastNameController.value.text;
      final dob = dobController.value.text;

      final emailId = userEmailController.value.text;
      final mobileNo = phoneNumberController.value.text;
      final address = addressController.value.text;
      final city = cityController.value.text;
      final pinCode = pinCodeController.value.text;
      final state = stateCodeController.value.text;
      final otherTalent = userOtherTalentController.value.text;

      if(dob.isEmptyOrNull) {
        Fluttertoast.showToast(
            msg: "Please Enter your DOB",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else if (_verticalGroupValue2 == "Others"){
        if(otherTalent.isEmptyOrNull) {
          Fluttertoast.showToast(
              msg: "Please Enter your Telent",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else{
          await sendToServer(emailId, mobileNo, address, city, state, pinCode, otherTalent, firstName, lastName, dob);
        }
      }
      else{
        await sendToServer(emailId, mobileNo, address, city, state, pinCode, otherTalent, firstName, lastName, dob);
      }
    }
  }

  Future<void> sendToServer(String emailId, String mobileNo, String address, String city, String state, String pinCode, String otherTalent, String firstName, String lastName, String dob) async {
     if(!agree){
      _currentStep <= 1 ? setState(() => _currentStep = 1) : null;
    }
    else {
      final Map<String, dynamic> contactDetail = <String, dynamic>{};
      contactDetail['emailId'] = emailId;
      contactDetail['mobileNo'] = mobileNo;
      contactDetail['address'] = address;
      contactDetail['city'] = city;
      contactDetail['state'] = state;
      contactDetail['pincode'] = pinCode;
      contactDetail['country'] = "India";


      var eventType = "";
      if (otherTalent.isEmptyOrNull) {
        eventType = _verticalGroupValue2;
      } else {
        eventType = otherTalent;
      }


      final Map<String, dynamic> data = <String, dynamic>{};
      data['pid'] = "pidWZEDjxL6EZfws";
      data['firstName'] = firstName;
      data['lastName'] = lastName;
      data['gender'] = _verticalGroupValue.toUpperCase();
      data['dob'] = dob.toString();
      data['contactDetail'] = contactDetail;
      data['eventType'] = eventType;
      data['participantType'] = "OTHERS";
      data['status'] = true;


      showDialog(context: context, builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        );
      });

      HomeRepository homeRepository = getIt<HomeRepository>();

      try {
        final orderInit = await homeRepository.eventPayment(data);
        debugPrint(orderInit.toString());
        createOrder(orderInit.key, orderInit.orderId, '', '');
      } catch (e) {
        Navigator.pop(context);
        debugPrint(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
