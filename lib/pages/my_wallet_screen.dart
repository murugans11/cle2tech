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

class MyWallet extends StatefulWidget {
  static const String routeName = "/MyWallet";

  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();
  var myWalletBal = "0";

 void getMyWallet() async {
    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
     var myWalletBalance = await homeRepository.getMyWallet(token);
      setState(() {
        myWalletBal = myWalletBalance;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    getMyWallet();
  }

  @override
  Widget build(BuildContext context) {
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
          text: 'My Wallet',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: ListView(children: [
        const SizedBox(height: 10),
        Container(
          height: 300,
          width: 300,
          alignment: Alignment.center,
          child: Image.asset(
            AppTheme.of(context)?.assets.wallet_Img ?? '',
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: MyGoogleTextWhitAli(
            text: "Your Shopeein Wallet Balance ₹ $myWalletBal",
            fontSize: 16,
            fontColor: Colors.black,
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: textColors),
            ),
          ),
          child: const ExpansionTile(
            title: Text('Terms and conditions'),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(12.0),
                child: ReadMoreText(
                  "Your Wellet money will be added in your Shopeein's Wallet. Which can be utilized for Shopping Clothes. Groceries, Accessories, beauty Products etc in Shopeein APP (Ios/Android) or www.shopeein.com.  It can be Used In WWW.SHOPEEIN.COM / SHOPEEIN APP for Purchasing Purpose Only. ",
                  trimLines: 2,
                  colorClickableText: primaryColor,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
