import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../pages/product_detail_screen.dart';

class ProductGreedShow1 extends StatefulWidget {
  const ProductGreedShow1({
    Key? key,
    required this.image,
    required this.productTitle,
    required this.productPrice,
    required this.discountPercentage,
    required this.isSingleView,
    required this.callCat
  }) : super(key: key);
  final String image;
  final String productTitle;
  final String productPrice;
  final String discountPercentage;
  final bool isSingleView;
  final Function callCat;

  @override
  State<ProductGreedShow1> createState() => _ProductGreedShow1State();
}

class _ProductGreedShow1State extends State<ProductGreedShow1> {
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  @override
  Widget build(BuildContext context) {
    debugPrint('Image${widget.image}');
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
                        widget.callCat;
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
                        // const ProductDetailScreen().launch(context);
                         widget.callCat;
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
                         placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
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
                MyGoogleText(
                  text: '\u{20B9}${widget.productPrice}',
                  fontSize: 14,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: [
                      RatingBarWidget(
                        rating: initialRating,
                        activeColor: ratingColor,
                        inActiveColor: ratingColor,
                        size: 18,
                        onRatingChanged: (aRating) {
                          setState(() {
                            initialRating = aRating;
                          });
                        },
                      ),
                      const SizedBox(
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
                      ),
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
