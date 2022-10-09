
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../models/feature/feature_productes.dart';
import '../widgets/buttons.dart';
import '../widgets/castomar_review_commends.dart';
import '../widgets/product_greed_view_widget.dart';
import '../widgets/product_greed_view_widget1.dart';
import '../widgets/review_bottom_sheet_1.dart';
import '../widgets/single_product_total_review.dart';
import 'cart_screen.dart';


class ProductDetailScreen extends StatefulWidget {
  static const String routeName = "/ProductDetailScreen";
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  PageController pageController = PageController(initialPage: 1);
  final pictures = [
    'images/woman.png',
    'images/woman2.png',
    'images/woman3.png'
  ];
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;
  String discountPercentage = '-50%';

  String selectedSize = '';
  final sizeList = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];
  Color selectedColor = const Color(0xFFffffff);
  final colorList = const [
    Color(0xFFA5C7F1),
    Color(0xFFEC6793),
    Color(0xFF21223E),
    Color(0xFF15949C),
  ];
  int simpleIntInput = 0;

  int initialValueFromText = 0;

  List<String> peopleReviewName = [
    'Abdul Korim',
    'Marvin McKinney',
    'Jenny Wilson',
  ];
  List<String> peopleReviewCommends = [
    'Nibh nibh quis dolor in. Etiam cras nisi, turpis quisque diam',
    'Nibh nibh quis dolor in. Etiam cras nisi, turpis quisque diam',
    'Nibh nibh quis dolor in. Etiam cras nisi, turpis quisque diam'
  ];
  List<int> peopleReviewRatings = [3, 4, 2];
  List<String> peopleReviewPhoto = [
    'images/profilePic.jpg',
    'images/profilePic.jpg',
    'images/profilePic.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    final listingProduct  = ModalRoute.of(context)!.settings.arguments as ListingProduct;

    return Scaffold(
      backgroundColor: secondaryColor3,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            ///_____________Photo & Buttons_________________________
            Stack(
              children: [
                ///_______Photos____________
                CarouselSlider.builder(
                  itemCount: pictures.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    height: 300,
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: null,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                          color: secondaryColor3,
                          width: double.infinity,
                          child: Image(image: AssetImage(pictures[itemIndex]))),
                ),

                ///_________Favorite & Share Button_________________________________________________________
                Positioned(
                  right: 20,
                  top: 20,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: primaryColor.withOpacity(0.05),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: isFavorite
                              ? const Center(
                                  child: Icon(
                                    Icons.favorite,
                                    color: secondaryColor1,
                                  ),
                                )
                              : const Center(
                                  child: Icon(
                                  Icons.favorite_border,
                                  color: secondaryColor1,
                                )),
                        ),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: primaryColor.withOpacity(0.05),
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: const Center(
                              child: Icon(
                            FeatherIcons.share2,
                            color: secondaryColor1,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                ///__________BackButton__________________________________________________
                Positioned(
                  left: 10,
                  top: 20,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 20, bottom: 20, right: 20),
              width: double.infinity,
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
                  const MyGoogleText(
                    text: 'Blazer Trousers Suit',
                    fontSize: 20,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  Row(
                    children: [
                      const MyGoogleText(
                        text: '\$30.00',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '\$35.00',
                        style: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: textColors,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: secondaryColor3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const Center(
                          child: MyGoogleText(
                            text: '-50%',
                            fontSize: 14,
                            fontColor: secondaryColor1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      RatingBarWidget(
                        rating: initialRating,
                        activeColor: ratingColor,
                        inActiveColor: ratingColor,
                        size: 22,
                        onRatingChanged: (aRating) {
                          setState(() {
                            initialRating = aRating;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      const MyGoogleText(
                        text: '(22 Review)',
                        fontSize: 16,
                        fontColor: textColors,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const MyGoogleText(
                    text: 'Select Your Size',
                    fontSize: 16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),

                  ///__________Select Size_______________________________
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = sizeList[i];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: selectedSize == sizeList[i]
                              ? Container(
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    color: secondaryColor1,
                                  ),
                                  child: Center(
                                    child: MyGoogleText(
                                      text: sizeList[i],
                                      fontSize: 18,
                                      fontColor: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                    color: secondaryColor3,
                                  ),
                                  child: Center(
                                    child: MyGoogleText(
                                      text: sizeList[i],
                                      fontSize: 18,
                                      fontColor: textColors,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      itemCount: sizeList.length,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MyGoogleText(
                        text: 'Select Colors',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        width: 110,
                        child: Center(
                          child: MyGoogleText(
                            text: 'Quantity',
                            fontSize: 16,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///__________Select Color Buttons & Quantity button______________________________
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///__________Select Color Buttons___________________________________
                      SizedBox(
                        height: 46,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = colorList[i];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: selectedColor == colorList[i]
                                  ? Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        color: colorList[i],
                                      ),
                                      child: const Center(
                                          child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )),
                                    )
                                  : Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        color: colorList[i],
                                      ),
                                    ),
                            ),
                          ),
                          itemCount: colorList.length,
                        ),
                      ),

                      ///Quantity button______________________________
                      SizedBox(
                        width: 110,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  initialValueFromText > 1
                                      ? initialValueFromText--
                                      : null;
                                });
                              },
                              child: Material(
                                elevation: 4,
                                color: secondaryColor3,
                                borderRadius: BorderRadius.circular(30),
                                child: const SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Center(
                                    child: Icon(FeatherIcons.minus,
                                        size: 25, color: textColors),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              initialValueFromText.toString(),
                              style: GoogleFonts.dmSans(fontSize: 18),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  initialValueFromText++;
                                });
                              },
                              child: Material(
                                elevation: 4,
                                color: secondaryColor3,
                                borderRadius: BorderRadius.circular(30),
                                child: const SizedBox(
                                  width: 33,
                                  height: 33,
                                  child: Center(
                                    child: Icon(Icons.add,
                                        size: 25, color: textColors),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///_____________Description________________________________
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: textColors),
                      ),
                    ),
                    child: const ExpansionTile(
                      title: Text('Description'),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: ReadMoreText(
                            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          /*child: ReadMoreText(
                            'These product details can be one sentence, a short paragraph or bulleted. They can be serious, funny or quirky. They can be located right next to or underneath product titles and product images. They can be scannable selling points or have strong readability.',
                            trimLines: 2,
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                color: textColors,
                              ),
                            ),
                            colorClickableText: secondaryColor1,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: const TextStyle(
                              color: secondaryColor1,
                            ),
                          ),*/
                        ),
                      ],
                    ),
                  ),

                  ///____________Reviews_______________________________
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: textColors),
                      ),
                    ),
                    child: ExpansionTile(
                      title: const Text('Reviews'),
                      children: <Widget>[
                        ///________TotalReview_________________________________
                        const SingleProductTotalReview(),
                        ButtonType2(
                          buttonText: 'Write a review',
                          buttonColor: primaryColor,
                          onPressFunction: () {
                            showMaterialModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              context: context,
                              builder: (context) => initialValueFromText > 2
                                  ? const GivingRatingBottomSheet()
                                  : const ReviewBottomSheet(),
                            );
                          },
                        ),
                        CastomarReviewCommends(
                            peopleReviewName: peopleReviewName,
                            peopleReviewPhoto: peopleReviewPhoto,
                            peopleReviewRatings: peopleReviewRatings,
                            peopleReviewCommends: peopleReviewCommends),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  ///_____________Delivery & Services__________________________
                  const MyGoogleText(
                    text: 'Delivery & Services',
                    fontSize: 16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: secondaryColor1.withOpacity(.20),
                              ),
                              child: const Center(
                                  child: Icon(
                                FeatherIcons.truck,
                                size: 18,
                              )),
                            ),
                            const SizedBox(width: 8),
                            const MyGoogleText(
                              text: 'Get it by Mon, 12 May',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: secondaryColor1.withOpacity(.20),
                              ),
                              child: const Center(
                                  child: Icon(
                                FeatherIcons.creditCard,
                                size: 18,
                              )),
                            ),
                            const SizedBox(width: 8),
                            const MyGoogleText(
                              text: 'Pay on delivery available',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                color: secondaryColor1.withOpacity(.20),
                              ),
                              child: const Center(
                                  child: Icon(
                                FeatherIcons.repeat,
                                size: 18,
                              )),
                            ),
                            const SizedBox(width: 8),
                            const Flexible(
                              child: MyGoogleText(
                                text:
                                    'Easy 30 days return & exchange available',
                                fontSize: 16,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  ///__________________Related Products____________________________
                  const MyGoogleText(
                    text: 'Related Products',
                    fontSize: 16,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  const SizedBox(height: 15),
                  HorizontalList(itemCount: 20, itemBuilder: (_,index){
                    return const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: ProductGreedShow(
                        image: 'images/woman.png',
                        productTitle: 'Blazer Trousers Suit',
                        productPrice: '33.30',
                        discountPercentage: '-30%',
                        isSingleView: false,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: secondaryColor3,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 25, bottom: 30, left: 15, right: 15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Button1(
                      buttonText: 'Buy now',
                      buttonColor: primaryColor,
                      onPressFunction: () => const CartScreen().launch(context)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ButtonType2(
                      buttonText: 'Add to Cart',
                      buttonColor: primaryColor,
                      onPressFunction: ()  => const CartScreen().launch(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
