import 'package:flutter/material.dart';


import '../constants/constants.dart';

class CartCostSection extends StatelessWidget {
  const CartCostSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MyGoogleText(
          text: 'Your Order',
          fontSize: 18,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MyGoogleText(
                text: 'Subtotal',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\$70.00',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MyGoogleText(
                text: 'Delivery Fee',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\$6.00',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MyGoogleText(
                text: 'VAT',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\$00.00',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1,
            color: textColors,
          ))),
        ),
        Padding(
          padding: const EdgeInsets.all(8.00),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              MyGoogleText(
                text: 'Total Amount',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\$76.00',
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
