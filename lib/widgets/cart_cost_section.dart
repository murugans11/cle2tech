import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CartCostSection extends StatelessWidget {

   const CartCostSection({
    Key? key,
    required this.price,
    required this.discount,
    required this.couponDiscount,
    required this.deliveryCharges,
    required this.totalAmount,
    required this.count,

  }) : super(key: key);



  final int price;
  final int discount;
  final int couponDiscount;
  final int deliveryCharges;
  final int totalAmount;
  final int count;



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
            children:  [
               MyGoogleText(
                text: 'Price($count Items)',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\u{20B9}$price',
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
            children:  [
              const MyGoogleText(
                text: 'Discount',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\u{20B9}$discount',
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
            children:  [
              const MyGoogleText(
                text: 'Coupon Discount',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\u{20B9}$couponDiscount',
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
            children:  [
              const MyGoogleText(
                text: 'Delivery Fee',
                fontSize: 16,
                fontColor: textColors,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\u{20B9}$deliveryCharges',
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
            children:  [
              const MyGoogleText(
                text: 'Total Amount',
                fontSize: 18,
                fontColor: Colors.black,
                fontWeight: FontWeight.normal,
              ),
              MyGoogleText(
                text: '\u{20B9}$totalAmount',
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
