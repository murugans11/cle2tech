import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/models/wishlist/verifywishlist.dart';

import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/cart/CartRequest.dart';

import '../models/feature/feature_productes.dart';
import '../models/wishlist/toggle_wishList_request.dart';
import '../utils/device/custom_error.dart';
import '../widgets/buttons.dart';
import '../widgets/castomar_review_commends.dart';
import '../widgets/error_dialog.dart';
import '../widgets/product_greed_view_widget.dart';
import '../widgets/review_bottom_sheet_1.dart';
import '../widgets/single_product_total_review.dart';
import 'auth_screen/log_in_screen.dart';

import 'package:string_validator/string_validator.dart';

import 'cart_screen.dart';
import 'confirm_order_screen.dart';

final counter = ValueNotifier<bool>(false);

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = "/ProductDetailScreen";

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  SharedPreferenceHelper sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();
  VerifyWishlist response = VerifyWishlist();

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  _asyncMethod() async {
    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.verifyWishList(token);
      setState(() {});
    }
  }

  bool _isLoaderVisible = false;
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  String selectedSize = '';

  final sizeList = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  int selectedColorValue = 0;

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

  Container chooseColorWidget(List<dynamic> images, int index, Color color) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(images[index]),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.zero),
        border: Border.all(
          width: 2,
          color: color,
        ),
      ),
    );
  }

  String getValues(value) {
    debugPrint('value${value.toString()}');
    if (contains(value.toString(), '[')) {
      List list = value as List;
      return list[0]['displayName'].toString() ?? " ";
    } else {
      return value.toString();
    }
  }

  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  FutureOr<void> _buyNow(String token, CartRequest cartRequest) async {
    try {
      final response =
          await homeRepository.addUpdateDeleteCart(token, cartRequest);

      navigateLogin();
    } on CustomError catch (e) {
      errorDialog(context, e.errMsg);
    }
  }

  FutureOr<void> _addToCart(String token, CartRequest cartRequest) async {
    try {
      final response = await homeRepository.addUpdateDeleteCart(token, cartRequest);

      Fluttertoast.showToast(
          msg: "Successfully added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pushNamed(context, CartScreen.routeName);
    } on CustomError catch (e) {
      errorDialog(context, e.errMsg);
    }
  }

  void navigateLogin() {
    Navigator.pushNamed(context, ConfirmOrderScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
    }

    final listingProduct =
        ModalRoute.of(context)!.settings.arguments as ListingProduct;

    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    /// Get the images
    var images = [];
    listingProduct.keyDetails?.variant?[selectedColorValue].media
        ?.forEach((imageUrl) {
      var image =
          imageUrl.resourcePath.split('.com').sublist(1).join('.com').trim();
      images.add(
          'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/612x612/filters:format(png)/$image');
    });

    final title = listingProduct.keyDetails?.productTitle;

    final sellingPrice =
        listingProduct.keyDetails?.variant?[selectedColorValue].sellingPrice;

    final retailPrice =
        listingProduct.keyDetails?.variant?[selectedColorValue].retailPrice;

    final description =
        listingProduct.keyDetails?.description.replaceAll(exp, '');

    List<Attributes> attributes =
        listingProduct.attributeGroup?[0].attributes ?? [];

    int percent = ((int.parse(retailPrice) - int.parse(sellingPrice)) /
            int.parse(retailPrice) *
            100)
        .toInt();

    final highlights = listingProduct.keyDetails?.highlights;

    var selectColorImage = [];

    var selectSize = [];

    listingProduct.keyDetails?.variant?.forEach((variant) {
      var image = variant.media?[0].resourcePath
          .split('.com')
          .sublist(1)
          .join('.com')
          .trim();
      selectColorImage.add('https://dvlt0mtg4c3zr.cloudfront.net/fit-in/212x212/filters:format(png)/$image');
    });

    final productId = listingProduct.id;

    final sku = listingProduct.keyDetails?.variant?[selectedColorValue].sku;

    counter.value = false;

    if (response.user != null) {
      response.user?.wishlist?.forEach((element) {
        if (sku == element.sku || productId == element.listingId) {
          isFavorite = true;
          counter.value = true;
        }
      });
    }

    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitCubeGrid(
          color: Colors.red,
          size: 50.0,
        ),
      ),
      overlayOpacity: 0.8,
      overlayWholeScreen: false,
      overlayHeight: 100,
      overlayWidth: 100,
      child: Scaffold(
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
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      // onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                      width: MediaQuery.of(context).size.width,
                      color: secondaryColor2,
                      child: Image(
                        image: NetworkImage(images[itemIndex]),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),

                  ///_________Favorite & Share Button_________________________________________________________
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            // getting token
                            var token = await sharedPreferenceHelper.authToken;
                            if (token != null) {
                              HomeRepository homeRepository =
                                  getIt<HomeRepository>();

                              if (!isFavorite) {
                                var toggleWishListRequest =
                                    ToggleWishListRequest(
                                        productId: productId,
                                        sku: sku,
                                        action: "add");
                                await homeRepository
                                    .toggleWishList(toggleWishListRequest);

                                isFavorite = !isFavorite;
                                counter.value = true;
                              } else {
                                var toggleWishListRequest =
                                    ToggleWishListRequest(
                                        productId: productId,
                                        sku: sku,
                                        action: "remove");
                                await homeRepository
                                    .toggleWishList(toggleWishListRequest);

                                isFavorite = !isFavorite;
                                counter.value = false;
                              }
                            }
                          },
                          child: ValueListenableBuilder<bool>(
                              valueListenable: counter,
                              builder: (context, value, _) {
                                return Container(
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
                                  child: value
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
                                          ),
                                        ),
                                );
                              }),
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

              const SizedBox(height: 5),

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
                    MyGoogleText(
                      text: title,
                      fontSize: 20,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        MyGoogleText(
                          text: '\u{20B9}$sellingPrice',
                          fontSize: 16,
                          fontColor: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '\u{20B9}$retailPrice',
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
                            border:
                                Border.all(width: 1, color: secondaryColor3),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Center(
                            child: MyGoogleText(
                              text: '-${percent.toString()}%',
                              fontSize: 14,
                              fontColor: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sold By : ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: 'SHOPPEEN',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Status : ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: 'In-Stock',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'COD : ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: 'Available',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Shipping : ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              TextSpan(
                                text: 'Free',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
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
                      fontWeight: FontWeight.bold,
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
                                      color: primaryColor,
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

                    ///__________Select Color Buttons & Quantity button______________________________
                    const MyGoogleText(
                      text: 'Select Colors',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 10.0),

                    HorizontalList(
                      spacing: 10,
                      itemCount: selectColorImage.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColorValue = index;
                                });
                              },
                              child: selectedColorValue == index
                                  ? chooseColorWidget(
                                      selectColorImage,
                                      index,
                                      primaryColor,
                                    )
                                  : chooseColorWidget(
                                      selectColorImage,
                                      index,
                                      secondaryColor3,
                                    ),
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 10.0),

                    ///__________Select Color Buttons & Quantity button______________________________

                    //const SizedBox(height: 10),
                    const MyGoogleText(
                      text: 'Quantity',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 10),

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

                    const SizedBox(height: 20),

                    const MyGoogleText(
                      text: 'Check Delivery',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),

                    const SizedBox(height: 10),

                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Pincode',
                      ),
                    ),

                    ///_____________Description________________________________
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1, color: textColors),
                        ),
                      ),
                      child: ExpansionTile(
                        title: const Text('Description'),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: ReadMoreText(
                              description,
                              trimLines: 2,
                              colorClickableText: primaryColor,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
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
                            peopleReviewCommends: peopleReviewCommends,
                          ),
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
                      fontWeight: FontWeight.bold,
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
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColor,
                                ),
                                child: const Center(
                                    child: Icon(
                                  FeatherIcons.truck,
                                  size: 18,
                                  color: Colors.white,
                                )),
                              ),
                              const SizedBox(width: 8),
                              const MyGoogleText(
                                text: 'Delivered in 7-9 days',
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
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColor,
                                ),
                                child: const Center(
                                    child: Icon(
                                  FeatherIcons.repeat,
                                  size: 18,
                                  color: Colors.white,
                                )),
                              ),
                              const SizedBox(width: 8),
                              const MyGoogleText(
                                text: 'Return & Replacement',
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
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColor,
                                ),
                                child: const Center(
                                    child: Icon(
                                  FeatherIcons.disc,
                                  size: 18,
                                  color: Colors.white,
                                )),
                              ),
                              const SizedBox(width: 8),
                              const MyGoogleText(
                                text: '4 hrs express delivery',
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
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  color: primaryColor,
                                ),
                                child: const Center(
                                    child: Icon(
                                  FeatherIcons.creditCard,
                                  size: 18,
                                  color: Colors.white,
                                )),
                              ),
                              const SizedBox(width: 8),
                              const MyGoogleText(
                                text: 'Pay online or UPI id',
                                fontSize: 16,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(
                      height: 10,
                    ),
                    const MyGoogleText(
                      text: 'Highlights',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    Table(
                      children: [
                        for (var attribute in highlights!)
                          TableRow(children: [
                            TableCell(
                              child: Row(
                                children: [
                                  MyGoogleText(
                                    text: '\u2022 $attribute' ?? '',
                                    fontSize: 16,
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            )
                          ])
                      ],
                    ),

                    ///product details
                    const SizedBox(height: 10),
                    const MyGoogleText(
                      text: 'Product Details',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),

                    Table(
                        // border: TableBorder.all(width: 1.0, color: Colors.black,borderRadius: const BorderRadius.all(Radius.zero)),
                        children: [
                          for (var attribute in attributes)
                            TableRow(
                              children: [
                                TableCell(
                                  child: Row(
                                    children: [
                                      MyGoogleText(
                                        text:
                                            attribute.displayName.toString() ??
                                                '',
                                        fontSize: 12,
                                        fontColor: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const Spacer(),
                                      MyGoogleText(
                                        text: getValues(attribute.value),
                                        fontSize: 16,
                                        fontColor: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ]),

                    ///__________________Related Products____________________________
                    const SizedBox(height: 15),

                    const MyGoogleText(
                      text: 'Similar Product',
                      fontSize: 16,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),

                    const SizedBox(height: 15),

                    HorizontalList(
                      spacing: 20,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductGreedShow1(
                          image: images[0],
                          productTitle: title,
                          productPrice: sellingPrice,
                          actualPrice: retailPrice,
                          discountPercentage: ("-$percent%"),
                          isSingleView: false,
                          callCat: () {},
                          navToLogin: () {
                            _navigateAndDisplaySelection(context);
                          },
                          productId: productId,
                          sku: sku,
                        );
                      },
                    ),
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
              padding: const EdgeInsets.only(
                  top: 25, bottom: 30, left: 15, right: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Button1(
                    buttonText: 'Buy now',
                    buttonColor: primaryColor,
                    onPressFunction: () async {
                      var token = await sharedPreferenceHelper.authToken;

                      if (token != null) {
                        setState(() {
                          _isLoaderVisible = context.loaderOverlay.visible;
                        });

                        if (initialValueFromText == 0) {
                          initialValueFromText = 1;
                        }

                        List<Items>? items = [];
                        var item = Items(sku: sku, qty: initialValueFromText);
                        items.add(item);
                        var request =
                            CartRequest(action: "update", items: items);

                        _buyNow(token, request);

                        if (_isLoaderVisible) {
                          context.loaderOverlay.hide();
                        }
                      } else {
                        Navigator.pushNamed(context, LogInScreen.routeName);
                      }
                    },
                  )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ButtonType2(
                        buttonText: 'Add to Cart',
                        buttonColor: primaryColor,
                        onPressFunction: () async {
                          var token = await sharedPreferenceHelper.authToken;

                          if (token != null) {
                            setState(() {
                              _isLoaderVisible = context.loaderOverlay.visible;
                            });

                            if (initialValueFromText == 0) {
                              initialValueFromText = 1;
                            }

                            List<Items>? items = [];
                            var item =
                                Items(sku: sku, qty: initialValueFromText);
                            items.add(item);
                            var request =
                                CartRequest(action: "update", items: items);

                            _addToCart(token, request);

                            if (_isLoaderVisible) {
                              context.loaderOverlay.hide();
                            }
                          } else {
                            Navigator.pushNamed(context, LogInScreen.routeName);
                          }

                          //  Navigator.pushNamed(context, CartScreen.routeName,
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
