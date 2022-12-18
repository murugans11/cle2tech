import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../cubit/cart/cart_list_response_cubit.dart';
import '../cubit/cart/cart_list_response_state.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/cart/CartRequest.dart';
import '../models/cart/CartResponse.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/cart_item_single_view.dart';
import 'check_out_screen.dart';
import 'confirm_order_screen.dart';

class CartScreen extends StatefulWidget {

  static const String routeName = "/CartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();

}

class _CartScreenState extends State<CartScreen> {
  var token;
  var update = true;

  SharedPreferenceHelper sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  _asyncMethod() async {
    final tokenValues = await sharedPreferenceHelper.authToken;
    setState(() {
      token = tokenValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (update) {
      if (token != null) {
        BlocProvider.of<CartListResponseCubit>(context).loadCartList(token);
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: MyGoogleText(
                text: '',
                fontSize: 16,
                fontColor: secondaryColor2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
        /*leading: GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
            bottomNavigationBarActions[_selectedIndex].launch(context, isNewTask: true);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),*/
        title: const MyGoogleText(
          text: 'Cart',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),

      body: token == null
          ? const Center(
              child: Text('CartList is empty'),
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 10),
                _postList(),
                _postList1(),
              ],
            ),

    );
  }

  Widget _postList() {
    return BlocBuilder<CartListResponseCubit, CartListResponseState>(
        builder: (context, state) {
      if (state is CartListResponseInitial) {
        return _loadingIndicator();
      }

      if (state is CartListResponseEmpty) {
        return const Center(
          child: Text('CartList is empty'),
        );
      }

      var cartListResponse = CartResponse();
      if (state is CartListResponseLoaded) {
        cartListResponse = state.cartResponse;
      }

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(8),
          itemCount: cartListResponse.cartDetails?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            String sku = cartListResponse.cartDetails?[index].sku ?? '';
            String qty =
                cartListResponse.cartDetails?[index].qty.toString() ?? '';

            String imageURL = '';
            var parts = cartListResponse
                .cartDetails?[index].resourcePath?.resourcePath
                ?.split('.com');
            if (parts != null) {
              var image = parts.sublist(1).join('.com').trim();
              imageURL =
                  'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/500x500/filters:format(png)/$image';
            }

            String sellingPrice =
                cartListResponse.cartDetails?[index].sellingPrice.toString() ??
                    '0';

            String retailPrice =
                cartListResponse.cartDetails?[index].retailPrice.toString() ??
                    '0';

            String mrp =
                cartListResponse.cartDetails?[index].mrp.toString() ?? '0';

            int percentage = ((int.parse(mrp) - int.parse(sellingPrice)) /
                    int.parse(mrp) *
                    100)
                .toInt();

            String productTitle =
                cartListResponse.cartDetails?[index].productTitle ?? '';

            final optionalAttributes =
                cartListResponse.cartDetails?[index].optionalAttributes;

            String displayColourName = '';
            String displaySizeName = '';

            optionalAttributes?.forEach((element) {
              if (element.displayName == "Color") {
                final attributeOptionValue = element.attributeOptionValue;
                attributeOptionValue?.forEach((element1) {
                  displayColourName = element1.displayName ?? '';
                });
              } else {
                final attributeOptionValue = element.attributeOptionValue;
                attributeOptionValue?.forEach((element1) {
                  displaySizeName = element1.displayName ?? '';
                });
              }
            });

            return CartItemsSingleView(
              resourcePath: imageURL,
              productTitle: productTitle,
              displayColourName: displayColourName,
              displaySizeName: displaySizeName,
              sellingPrice: sellingPrice,
              mrp: mrp,
              percentage: percentage,
              callCat: () {
                deleteAnItemFromCart(cartListResponse, index, context);
              },
              callupdate: (currentQty) {
                updateAnItemFromCart(cartListResponse, index, context,currentQty);
              },
              qty: qty,
            );
          });
    });
  }

  void deleteAnItemFromCart(
      CartResponse cartListResponse, int index, BuildContext context) {
    setState(() {
      List<Items>? items = [];
      var item = Items(
          sku: cartListResponse.cartDetails?[index].sku,
          qty: cartListResponse.cartDetails?[index].qty);
      items.add(item);
      var request = CartRequest(action: "remove", items: items);

      BlocProvider.of<CartListResponseCubit>(context)
          .addUpdateDeleteCart(token, request);
      update = false;
    });
  }

  void updateAnItemFromCart(CartResponse cartListResponse, int index, BuildContext context,int qty) {

    setState(() {
      List<Items>? items = [];
      var item = Items(
          sku: cartListResponse.cartDetails?[index].sku,
          qty: qty);
      items.add(item);
      var request = CartRequest(action: "update", items: items);

      BlocProvider.of<CartListResponseCubit>(context).addUpdateDeleteCart(token, request);
      update = false;
    });
  }

  Widget _postList1() {
    return BlocBuilder<CartListResponseCubit, CartListResponseState>(
        builder: (context, state) {
      var cartListResponse = CartResponse();
      if (state is CartListResponseLoaded) {
        cartListResponse = state.cartResponse;
      }

      final int price = cartListResponse.priceDetails?.price ?? 0;
      final int sellingPrice = cartListResponse.priceDetails?.sellingPrice ?? 0;
      final int discount = cartListResponse.priceDetails?.discount ?? 0;
      final int couponDiscount =
          cartListResponse.priceDetails?.couponDiscount ?? 0;
      final int deliveryCharges =
          cartListResponse.priceDetails?.deliveryCharges ?? 0;
      final int totalAmount = cartListResponse.priceDetails?.totalAmount ?? 0;
      final int count = cartListResponse.priceDetails?.count ?? 0;

      return count == 0
          ? const Center(
              child: Text('CartList is empty'),
            )
          : Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  //const SizedBox(height: 20),
                  CartCostSection(
                      price: price,
                      discount: discount,
                      couponDiscount: couponDiscount,
                      deliveryCharges: deliveryCharges,
                      totalAmount: totalAmount,
                      count: count),

                  Button1(
                      buttonText: 'Check Out',
                      buttonColor: primaryColor,
                      onPressFunction: () {
                        Navigator.pushNamed(context, ConfirmOrderScreen.routeName);
                      }),
                ],
              ),
            );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
