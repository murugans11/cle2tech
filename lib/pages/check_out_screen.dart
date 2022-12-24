import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/payment_method_screen.dart';
import 'package:shopeein/pages/shipping_address.dart';


import '../constants/constants.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import 'confirm_order_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  List<String> paymentImageList = [
    'images/paypal.png',
    'images/bkash.png',
    'images/visa.png'
  ];
  List<String> paymentNameList = ['PayPal', 'Bkash', 'Visa'];
  String whichPaymentIsChecked = '';
  @override
  Widget build(BuildContext context) {
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
          text: 'Check Out',
          fontColor: secondaryColor2,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              width: context.width(),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///____________Shipping_address__________________________
                  const MyGoogleText(
                    text: 'Shipping Address',
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: secondaryColor3),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const MyGoogleText(
                              text: 'Shaidul Islam',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            TextButton(
                              onPressed: () {
                                 ShippingAddressPage().launch(context);
                              },
                              child: const MyGoogleText(
                                text: 'Change',
                                fontSize: 16,
                                fontColor: secondaryColor1,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                        const Flexible(
                          child: MyGoogleText(
                            text: '8 Bukit Batok Street 41, Bangladesh,361025',
                            fontSize: 16,
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ///_______Payment_method________________________
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const MyGoogleText(
                        text: 'Payment Method',
                        fontSize: 20,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      TextButton(
                        onPressed: () {
                          const PaymentMethodScreen().launch(context);
                        },
                        child: const MyGoogleText(
                          text: 'Change',
                          fontSize: 16,
                          fontColor: secondaryColor1,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: secondaryColor3),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: paymentImageList.length,
                        itemBuilder: (context, i) {
                          return whichPaymentIsChecked == paymentNameList[i]
                              ? Card(
                                  elevation: 0.5,
                                  child: ListTile(
                                    leading: Image(
                                        image: AssetImage(paymentImageList[i])),
                                    title: MyGoogleText(
                                      text: paymentNameList[i],
                                      fontSize: 16,
                                      fontColor: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          whichPaymentIsChecked =
                                              paymentNameList[i];
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.radio_button_checked,
                                        color: secondaryColor1,
                                      ),
                                    ),
                                  ),
                                )
                              : ListTile(
                                  leading: Image(
                                      image: AssetImage(paymentImageList[i])),
                                  title: MyGoogleText(
                                    text: paymentNameList[i],
                                    fontSize: 16,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        whichPaymentIsChecked =
                                            paymentNameList[i];
                                      });
                                    },
                                    icon: const Icon(Icons.radio_button_off),
                                  ),
                                );
                        }),
                  ),
                  const SizedBox(height: 20),

                  ///_____Cost_Section_____________
                  const CartCostSection(price: 0,discount: 0,couponDiscount: 0,deliveryCharges: 0,totalAmount: 0,count: 0,),

                  ///___________Pay_Now_Button___________________________________
                  Button1(
                      buttonText: 'Pay Now',
                      buttonColor: primaryColor,
                      onPressFunction: () {
                        Navigator.pushNamed(context, ConfirmOrderScreen.routeName);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
