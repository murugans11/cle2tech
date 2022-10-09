import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/cart_screen.dart';
import '../pages/category_screen.dart';

import '../pages/home_page.dart';
import '../pages/profile_screen.dart';
import '../pages/wishlist_screen.dart';


var bottomNavigationBarActions = const [
  HomePage(),
  CartScreen(),
  CategoryScreen(),
  WishlistScreen(),
  ProfileScreen(),
];

const primaryColor = Color(0xFFfe5633);
const secondaryColor1 = Color(0xFFE2396C);
const secondaryColor2 = Color(0xFFFBFBFB);
const secondaryColor3 = Color(0xFFE5E5E5);
const titleColors = Color(0xFF1A1A1A);
const textColors = Color(0xFF828282);
const ratingColor = Color(0xFFFFB03A);


const categoryColor1 = Color(0xFFFCF3D7);
const categoryColor2 = Color(0xFFDCF7E3);

final TextStyle kTextStyle = GoogleFonts.dmSans(
  textStyle: const TextStyle(
    color: textColors,
    fontSize: 16,
  ),
);

class MyGoogleText extends StatelessWidget {
  const MyGoogleText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontColor,
      required this.fontWeight})
      : super(key: key);
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class MyGoogleTextWhitAli extends StatelessWidget {
  const MyGoogleTextWhitAli({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontColor,
    required this.fontWeight,
    required this.textAlign,
  }) : super(key: key);
  final String text;
  final double fontSize;
  final Color fontColor;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: fontColor,
        ),
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: secondaryColor1),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
