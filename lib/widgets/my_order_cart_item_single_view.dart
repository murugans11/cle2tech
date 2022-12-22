import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/widgets/quantity_counter.dart';

import '../constants/constants.dart';
import '../pages/check_out_screen.dart';
import 'buttons.dart';

class MyOrderCartItemsSingleView extends StatefulWidget {

  const MyOrderCartItemsSingleView({
    Key? key,
    required this.productTitle,
    required this.resourcePath,
    required this.displayColourName,
    required this.displaySizeName,
    required this.sellingPrice,
    required this.mrp,
    required this.percentage,
    required this.qty,
  }) : super(key: key);

  final String resourcePath;
  final String productTitle;
  final String displayColourName;
  final String displaySizeName;
  final String sellingPrice;
  final String mrp;
  final int percentage;
  final String qty;


  @override
  State<MyOrderCartItemsSingleView> createState() => _MyOrderCartItemsSingleViewState();
}

class _MyOrderCartItemsSingleViewState extends State<MyOrderCartItemsSingleView> {
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
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            width: 1,
            color: secondaryColor3,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: CachedNetworkImage(
                imageUrl:
                    widget.resourcePath.isEmpty ? '' : widget.resourcePath,
                imageBuilder: (context, imageProvider) => Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: secondaryColor3,
                    ),
                    color: secondaryColor3,
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: context.width() / 2,
                    child: MyGoogleText(
                      text: widget.productTitle,
                      fontSize: 13,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MyGoogleText(
                      text: 'Color: ${widget.displayColourName}',
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
                      children: [
                        const MyGoogleText(
                          text: 'Size:',
                          fontSize: 12,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        const SizedBox(width: 5),
                        MyGoogleText(
                          text: widget.displaySizeName,
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
                        MyGoogleText(
                          text: '\u{20B9}${widget.sellingPrice}',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '\u{20B9}${widget.mrp}',
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
                          width: context.width() / 5.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 1, color: secondaryColor3),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: MyGoogleText(
                              text: '-${widget.percentage}% off',
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
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: MyGoogleText(
                      text: 'Qty: ${widget.qty}',
                      fontSize: 16,
                      fontColor: Colors.green,
                      fontWeight: FontWeight.normal,
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
