import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/app_theme.dart';
import '../constants/constants.dart';

class GiftGreedView extends StatefulWidget {
  const GiftGreedView({
    Key? key,
    required this.productTitle,
    required this.isSingleView,
    required this.imageurl,
  }) : super(key: key);

  final String productTitle;
  final String imageurl;
  final bool isSingleView;


  @override
  State<GiftGreedView> createState() => _GiftGreedViewState();
}

class _GiftGreedViewState extends State<GiftGreedView> {
  bool isFavorite = false;
  double initialRating = 0;
  late double rating;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              widget.imageurl.isEmpty
                  ? Container(
                      height: 221,
                      width: 187,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                              AppTheme.of(context)?.assets.gift1 ?? ''),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: widget.imageurl,
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
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: MyGoogleText(
                    text: widget.productTitle,
                    fontSize: 13,
                    fontColor: textColors,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  width: 150.0,
                  child: MyGoogleText(
                    text: "You Won a Gift Card on Your Purchase",
                    fontSize: 13,
                    fontColor: Colors.green,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
