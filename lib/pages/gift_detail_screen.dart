import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:scratcher/widgets.dart';
import 'package:shopeein/pages/product_detail_screen.dart';
import 'package:shopeein/pages/shipping_address_gift.dart';

import '../constants/app_theme.dart';
import '../constants/constants.dart';

import '../cubit/cart/single_category_group/single_category_items_cubit.dart';

import '../cubit/cart/single_category_group/single_category_items_state.dart';
import '../data/network/constants/endpoints.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/categoriesbyname/categorieItems.dart';
import '../models/feature/feature_productes.dart';
import '../models/gift/gift_response.dart';
import '../models/wishlist/verifywishlist.dart';
import '../widgets/buttons.dart';
import '../widgets/gift_greed_view_widget.dart';
import '../widgets/product_greed_view_widget.dart';
import 'auth_screen/log_in_screen.dart';

class GiftDetailPage extends StatefulWidget {
  static const String routeName = "/GiftDetailPage";

  const GiftDetailPage({super.key});

  @override
  State<GiftDetailPage> createState() => _GiftDetailPageState();
}

class _GiftDetailPageState extends State<GiftDetailPage> {
  @override
  void initState() {
    super.initState();
    // _asyncMethod();
  }

  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    Gift requestOtpResponse =
        ModalRoute.of(context)!.settings.arguments as Gift;

    String imageURL = requestOtpResponse.resourcePath ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const MyGoogleText(
          text: 'My Gift',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const SizedBox(
            width: double.infinity,
            child: MyGoogleTextWhitAli(
              text: "Congratulations",
              fontSize: 30,
              fontColor: Colors.green,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: double.infinity,
            child: MyGoogleTextWhitAli(
              text: "You Won A Scratch Card on Your Purchase",
              fontSize: 16,
              fontColor: Colors.black,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          Scratcher(
            accuracy: ScratchAccuracy.high,
            threshold: 50,
            brushSize: 75,
            onThreshold: () {
              setState(() {
                _opacity = 1;
              });
            },
            image: Image.asset(
              AppTheme.of(context)?.assets.gift2 ?? '',
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _opacity,
              child: Container(
                height: 300,
                width: 300,
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  imageUrl: imageURL,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Button1(
              buttonText: 'Claim',
              buttonColor: primaryColor,
              onPressFunction: () {
                var giftId1 = requestOtpResponse.id ?? "";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ShippingGiftAddressPage(
                        claimType: "SELF",
                        giftId: giftId1,
                      ),
                    ));
              }),
          const SizedBox(height: 15),
          Button1(
              buttonText: 'Gift to loved one',
              buttonColor: primaryColor,
              onPressFunction: () {
                var giftId1 = requestOtpResponse.id ?? "";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ShippingGiftAddressPage(
                        claimType: "OTHERS",
                        giftId: giftId1,
                      ),
                    ));
              }),
        ],
      ),
    );
  }
}
