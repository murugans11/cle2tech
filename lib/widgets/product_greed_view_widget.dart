import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/data/repository/home_repository.dart';
import 'package:shopeein/data/repository/login_repository.dart';
import 'package:shopeein/pages/auth_screen/log_in_screen.dart';

import '../constants/constants.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/wishlist/toggle_wishList_request.dart';
import '../models/wishlist/verifywishlist.dart';
import '../pages/product_detail_screen.dart';

class ProductGreedShow1 extends StatefulWidget {
  const ProductGreedShow1(
      {Key? key,
      required this.image,
      required this.productTitle,
      required this.productPrice,
      required this.actualPrice,
      required this.discountPercentage,
      required this.isSingleView,
      required this.callCat,
      required this.navToLogin,
      required this.productId,
      required this.sku,
      this.response})
      : super(key: key);
  final String image;
  final String productTitle;
  final String productPrice;
  final String actualPrice;
  final String discountPercentage;
  final bool isSingleView;
  final Function callCat;
  final Function navToLogin;
  final String productId;
  final String sku;
  final VerifyWishlist? response;

  @override
  State<ProductGreedShow1> createState() => _ProductGreedShow1State();
}

class _ProductGreedShow1State extends State<ProductGreedShow1> {
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.response != null) {
      if (widget.response?.user != null) {
        widget.response?.user?.wishlist?.forEach((element) {
          if (widget.sku == element.sku ||
              widget.productId == element.listingId) {
            isFavorite = true;
          }
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: secondaryColor3,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              widget.isSingleView
                  ? GestureDetector(
                      onTap: () {
                        //const ProductDetailScreen().launch(context);
                        widget.callCat();
                      },
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: secondaryColor3,
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.callCat();
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.image.isEmpty ? '' : widget.image,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 221,
                          width: 187,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            ),
                            color: secondaryColor3,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () async {

                    SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
                    var token = await sharedPreferenceHelper.authToken;
                    if (token != null) {
                      HomeRepository homeRepository = getIt<HomeRepository>();
                      if (!isFavorite) {
                        var toggleWishListRequest = ToggleWishListRequest(
                            productId: widget.productId,
                            sku: widget.sku,
                            action: "add");
                        await homeRepository.toggleWishList(toggleWishListRequest);

                        setState(() {
                          isFavorite = !isFavorite;
                        });

                      } else {
                        var toggleWishListRequest = ToggleWishListRequest(
                            productId: widget.productId,
                            sku: widget.sku,
                            action: "remove");
                        await homeRepository.toggleWishList(toggleWishListRequest);

                        setState(() {
                          isFavorite = !isFavorite;
                        });

                      }
                    } else {
                      widget.navToLogin();
                     // Navigator.pushNamed(context, LogInScreen.routeName);
                    }
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
                        : const Center(child: Icon(Icons.favorite_border)),
                  ),
                ),
              ),
              Positioned(
                left: 7,
                top: 10,
                child: Container(
                  height: 23,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: secondaryColor3),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: MyGoogleText(
                      text: widget.discountPercentage,
                      fontSize: 12,
                      fontColor: secondaryColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150.0,
                  child: MyGoogleText(
                    text: widget.productTitle,
                    fontSize: 13,
                    fontColor: textColors,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  children: [
                    MyGoogleText(
                      text: '\u{20B9}${widget.productPrice}',
                      fontSize: 14,
                      fontColor: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '\u{20B9}${widget.actualPrice}',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: textColors,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      RatingBarWidget(
                        rating: initialRating,
                        activeColor: ratingColor,
                        inActiveColor: ratingColor,
                        size: 18, onRatingChanged: (double rating) {},
                        /*onRatingChanged: (aRating) {
                         setState(() {
                            initialRating = aRating;
                          });
                        },*/
                      ),
                      /*const SizedBox(
                        width: 7,
                      ),
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.05),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Center(
                            child: Icon(
                          IconlyLight.bag,
                          color: primaryColor,
                        )),
                      ),*/
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
