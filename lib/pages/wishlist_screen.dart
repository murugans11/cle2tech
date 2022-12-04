import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopeein/pages/product_detail_screen.dart';

import '../constants/constants.dart';
import '../cubit/wishlist/wish_list_response_cubit.dart';
import '../cubit/wishlist/wish_list_response_state.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/feature/feature_productes.dart';
import '../models/wishlist/toggle_wishList_request.dart';
import '../models/wishlist/wish_list_response.dart';

import '../widgets/wishlist_greed_view_widget.dart';

class WishlistScreen extends StatefulWidget {

  static const String routeName = "/WishListPage";

  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> /*with WidgetsBindingObserver */ {

  var token;
  SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  @override
  void initState() {
    super.initState();
    // Add the observer.
    //WidgetsBinding.instance.addObserver(this);
    _asyncMethod();
  }

  @override
  void dispose() {
    // Remove the observer
   // WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

/* @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
      // widget is resumed
      debugPrint('resumed');
        break;
      case AppLifecycleState.inactive:
      // widget is inactive
        debugPrint('inactive');
        break;
      case AppLifecycleState.paused:
      // widget is paused
        debugPrint('paused');
        break;
      case AppLifecycleState.detached:
      // widget is detached
        debugPrint('detached');
        break;
    }

  }*/

  _asyncMethod() async {
   final tokenValues = await sharedPreferenceHelper.authToken;
    setState(() {
      token = tokenValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      BlocProvider.of<WishListResponseCubit>(context).loadWishList(token);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        title: const MyGoogleText(
          text: 'Wishlist ',
          fontColor: secondaryColor2,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: token == null
          ? const Center(
              child: Text('WishList is empty'),
            )
          : _postList(),
    );
  }

  Widget _postList() {
    return BlocBuilder<WishListResponseCubit, WishListResponseState>(
        builder: (context, state) {
      if (state is WishListResponseInitial) {
        return _loadingIndicator();
      }

      if (state is WishListResponseEmpty) {
        return const Center(
          child: Text('WishList is empty'),
        );
      }

      var wishListResponse = WishListResponse();
      if (state is WishListResponseLoaded) {
        wishListResponse = state.wishListResponse;
      }

      return Container(
        padding:
            const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: wishListResponse.listingProduct?.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) {
            return getItem(wishListResponse.listingProduct, index, context);
          },
        ),
      );
    });
  }

  WishListGreedShow getItem(List<ListingProduct>? listingProductList, int index, BuildContext context) {

    String imageURL = '';

    var parts = listingProductList?[index]
        .keyDetails
        ?.variant?[0]
        .media?[0]
        .resourcePath
        .split('.com');

    if (parts != null) {
      var image = parts.sublist(1).join('.com').trim();
      imageURL =
          'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/500x500/filters:format(png)/$image';
    }

    final sellingPrice =
        listingProductList?[index].keyDetails?.variant?[0].sellingPrice;

    final retailPrice =
        listingProductList?[index].keyDetails?.variant?[0].retailPrice;

    int percent = ((int.parse(retailPrice) - int.parse(sellingPrice)) /
            int.parse(retailPrice) *
            100)
        .toInt();

    final productId = listingProductList?[index].id;

    final sku = listingProductList?[index].keyDetails?.variant?[0].sku;

    return WishListGreedShow(
      image: imageURL,
      productTitle: listingProductList?[index].keyDetails?.productTitle,
      productPrice: sellingPrice,
      actualPrice: retailPrice,
      discountPercentage: ("-$percent%"),
      isSingleView: false,
      callCat: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: listingProductList?[index]);
      },
      deleteCat: () async {
        HomeRepository homeRepository = getIt<HomeRepository>();
        var toggleWishListRequest = ToggleWishListRequest(
            productId: productId,
            sku: sku,
            action: "remove");
        await homeRepository.toggleWishList(toggleWishListRequest);
        setState(() {
        });
      },
      productId: productId,
      sku: sku,
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
