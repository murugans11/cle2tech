import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/payment_method_screen.dart';
import 'package:shopeein/pages/shipping_address.dart';

import '../constants/constants.dart';
import '../cubit/cart/cart_list_response_cubit.dart';
import '../cubit/cart/cart_list_response_state.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/cart/CartRequest.dart';
import '../models/cart/CartResponse.dart';
import '../models/wishlist/verifywishlist.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/cart_item_single_view.dart';
import '../widgets/confirmation_popup.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  String _verticalGroupValue = "Cash on Delivery";
  final List<String> _status = ["Cash on Delivery", "Online Payment"];
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
                updateAnItemFromCart(
                    cartListResponse, index, context, currentQty);
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

  void updateAnItemFromCart(
      CartResponse cartListResponse, int index, BuildContext context, int qty) {
    setState(() {
      List<Items>? items = [];
      var item = Items(sku: cartListResponse.cartDetails?[index].sku, qty: qty);
      items.add(item);
      var request = CartRequest(action: "update", items: items);

      BlocProvider.of<CartListResponseCubit>(context)
          .addUpdateDeleteCart(token, request);
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

  Future<VerifyWishlist> _getLatest() async {
    SharedPreferenceHelper sharedPreferenceHelper =
        getIt<SharedPreferenceHelper>();
    HomeRepository homeRepository = getIt<HomeRepository>();
    VerifyWishlist response = VerifyWishlist();

    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.verifyWishList(token);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const MyGoogleText(
          text: 'Confirm Your Order',
          fontColor: secondaryColor2,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(5),
              width: context.width(),
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
                  ///____________Shipping_address__________________________
                  FutureBuilder<VerifyWishlist>(
                    future: _getLatest(),
                    builder: (BuildContext context,
                        AsyncSnapshot<VerifyWishlist> snapshot) {
                      return snapshot.hasData
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        MyGoogleText(
                                          text: 'Shipping Address',
                                          fontSize: 18,
                                          fontColor: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.check_circle,
                                          color: primaryColor,
                                        )
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, ShippingAddress.routeName);
                                      },
                                      child: const MyGoogleText(
                                        text: 'Change',
                                        fontSize: 16,
                                        fontColor: secondaryColor1,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  child: MyGoogleText(
                                    text: snapshot.data?.user?.addresses?[0]
                                            .address ??
                                        '',
                                    fontSize: 16,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        MyGoogleText(
                                          text: 'Shipping Address',
                                          fontSize: 18,
                                          fontColor: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.check_circle,
                                          color: primaryColor,
                                        )
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, ShippingAddress.routeName);
                                      },
                                      child: const MyGoogleText(
                                        text: 'Add Address',
                                        fontSize: 16,
                                        fontColor: secondaryColor1,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                              ],
                            );
                    },
                  ),

                  ///___________Items_view_________________________________
                  const MyGoogleText(
                    text: 'Order Summary',
                    fontSize: 18,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),

                  _postList(),

                  _postList1(),

                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(width: 1, color: textColors),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 60,
                          decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(width: 1, color: textColors)),
                          ),
                          child: const Center(
                              child: Icon(
                            Icons.percent,
                            color: textColors,
                          )),
                        ),
                        SizedBox(
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                cursorColor: textColors,
                                decoration: const InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    border: InputBorder.none,
                                    label: MyGoogleText(
                                      text: 'Coupon code',
                                      fontColor: textColors,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    )),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 60,
                            width: 80,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                color: primaryColor),
                            child: const Center(
                                child: MyGoogleText(
                                    text: 'Apply',
                                    fontSize: 14,
                                    fontColor: Colors.white,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  ///_____________Delivery details______________________________
                  /* Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          MyGoogleText(
                            text: 'Delivery details',
                            fontSize: 18,
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.check_circle,
                            color: primaryColor,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Flexible(
                            child: MyGoogleText(
                              text: 'Standard Delivery',
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Flexible(
                            child: MyGoogleText(
                              text: '26 May 2022  (Sun 26 - Wed 30)',
                              fontSize: 16,
                              fontColor: textColors,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),*/

                  ///_____________Payment Method______________________________
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              MyGoogleText(
                                text: 'Payment Method',
                                fontSize: 18,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              const PaymentMethodScreen().launch(context);
                            },
                            child: const MyGoogleText(
                              text: '',
                              fontSize: 16,
                              fontColor: secondaryColor1,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioGroup<String>.builder(
                                direction: Axis.horizontal,
                                groupValue: _verticalGroupValue,
                                horizontalAlignment:
                                    MainAxisAlignment.spaceAround,
                                activeColor: primaryColor,
                                onChanged: (value) => setState(() {
                                  _verticalGroupValue = value!;
                                }),
                                items: _status,
                                textStyle: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                                itemBuilder: (item) => RadioButtonBuilder(
                                  item,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  Button1(
                      buttonText: 'Pay Now',
                      buttonColor: primaryColor,
                      onPressFunction: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (BuildContext context, _, __) =>
                                const RedeemConfirmationScreen(
                              image: 'images/confirm_order_pupup.png',
                              mainText: 'Order successfully!',
                              subText:
                                  'Your order will be delivered soon. Thank you.',
                              buttonText: 'Back to Home',
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
