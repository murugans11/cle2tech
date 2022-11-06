import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/widgets/quantity_counter.dart';

import '../constants/constants.dart';

class CartItemsSingleView extends StatefulWidget {

  const CartItemsSingleView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<CartItemsSingleView> createState() => _CartItemsSingleViewState();
}

class _CartItemsSingleViewState extends State<CartItemsSingleView> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        right: 8,
        bottom: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              width: 1,
              color: secondaryColor3,
            )),
        child: Row(
          children: [

            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: secondaryColor3,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: secondaryColor3,
                  image: const DecorationImage(
                      image: AssetImage('images/woman.png')),
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MyGoogleText(
                    text: 'Para Homens ${widget.index}',
                    fontSize: 16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),

                const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child:  MyGoogleText(
                      text: 'Color:',
                      fontSize: 12,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),

                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [

                            MyGoogleText(
                              text: 'Size:',
                              fontSize: 12,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(width: 5),
                            MyGoogleText(
                              text: 'L',
                              fontSize: 14,
                              fontColor: Colors.red,
                              fontWeight: FontWeight.normal,
                            ),

                      ],
                    ),
                  ),
                ),

                 SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [

                        const MyGoogleText(
                          text: '\u{20B9}500',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),

                        const SizedBox(width: 10),

                        Text(
                          '\u{20B9}500',
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                              color: textColors,
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Container(
                          height: 30,
                          width: context.width()/5.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: secondaryColor3),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: MyGoogleText(
                              text: '-${50.toString()}% off',
                              fontSize: 14,
                              fontColor: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: context.width() / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyGoogleText(
                          text: 'Available',
                          fontSize: 16,
                          fontColor: Colors.green,
                          fontWeight: FontWeight.normal,
                        ),
                        QuantityCounter(initialValue: 0, sizeOfButtons: 22),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}
