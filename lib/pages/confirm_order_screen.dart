

import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:nb_utils/nb_utils.dart';

import 'package:shopeein/pages/payment_validation_page.dart';
import 'package:shopeein/pages/pin_code_verification_screen.dart';
import 'package:shopeein/pages/shipping_address.dart';
import 'package:shopeein/utils/dio/network_call_status_enum.dart';
import 'package:shopeein/widgets/offer_screen.dart';

import '../blocs/make_order/markorder_bloc.dart';
import '../blocs/make_order/markorder_event.dart';
import '../blocs/make_order/markorder_state.dart';

import '../constants/constants.dart';
import '../cubit/cart/cart_list_response_cubit.dart';
import '../cubit/cart/cart_list_response_state.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/cart/CartRequest.dart';
import '../models/cart/CartResponse.dart';
import '../models/otp_verify/OrderOtpVerifyRequest.dart';
import '../models/wishlist/verifywishlist.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/cart_item_single_view.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

import 'gift_screen.dart';

class ConfirmOrderScreen extends StatefulWidget {
  static const String routeName = "/ConfirmOrderScreen";

  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  var token = '';
  var orderId = '';
  var walletBalance = '';
  var update = true;
  var addressId = '';
  int paymantType = -1;

  String? gender;
  bool useShopeeinWallet = false;

  final _couponController = TextEditingController();
  SharedPreferenceHelper sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  void _initOrder() async {
    final tokenValues = await sharedPreferenceHelper.authToken;

    if (tokenValues != null) {
      BlocProvider.of<CartListResponseCubit>(context).loadCartList(tokenValues);
    }

    final orderInit = await homeRepository.getOrderInit(tokenValues ?? '');
    var parts = orderInit.split(':');
    var _orderId = parts[0].trim(); // prefix: "date"
    var walletBal = parts[1].trim(); // prefix: "date"

    debugPrint("orderId$orderId");
    debugPrint("walletBal$walletBal");

    setState(() {
      token = tokenValues ?? '';
      orderId = _orderId;
      walletBalance = walletBal;
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

  void applyCoupon(BuildContext context, String couponCode, String orderId) {
    setState(() {
      BlocProvider.of<CartListResponseCubit>(context)
          .applyCoupon(token, couponCode, orderId);
      update = false;
    });
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, OfferScreen.routeName);
    if (!mounted) return;
    setState(() {
      _couponController.text = result.toString();
    });
  }

  Future<VerifyWishlist> _getLatest() async {
    VerifyWishlist response = VerifyWishlist();
    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.verifyWishList(token);
    }
    return response;
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

      if (state is CartListResponseError) {
        var error = state.errorMessage;
        return Center(
          child: Text(error),
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

  final _razorpay = Razorpay();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });
    super.initState();
    _initOrder();
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    _couponController.dispose();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print(response);
    var order = response.orderId;
    var paymentId = response.paymentId;
    var signature = response.signature;
    var ids = " orderid $order +paymentId $paymentId +signature $signature";
    debugPrint("payment response $ids");

    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return PaymentValidationPage(
          token: token,
          order: order ?? '',
          paymentId: paymentId ?? '',
          signature: signature ?? '',
        );
      },
    ));

    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ids),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

  // create order
  void createOrder(
      String key, String orderId, String contactNumber, String email) async {
    /* String username = "rzp_live_MvPwKYplVlFBKd"; key
    String password = "0jPJM9bLryhb3w1VbYj0hpZB"; secret key
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": 1,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https("api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    print(res.body);
*/
    openGateway(key, orderId, contactNumber, email);
  }

  openGateway(String key, String orderId, String contactNumber, String email) {
    var options = {
      //'key': "rzp_live_MvPwKYplVlFBKd",
      'key': key,
      //'amount': 1, //in the smallest currency sub-unit.
      //'name': 'Shoppein.com',
      'order_id': orderId, // Generate order_id using Orders API
      //'description': 'Fine T-Shirt',
      // 'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': contactNumber,
        'email': email,
      }
    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {

    var addressList = [];

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
                    builder: (BuildContext context, AsyncSnapshot<VerifyWishlist> snapshot) {
                      var address = '';
                      if (snapshot.hasData) {
                         addressList = snapshot.data?.user?.addresses ?? [];
                        if(addressList.isNotEmpty){
                          addressId = snapshot.data?.user?.addresses?[0].addressId ?? '';
                          address = snapshot.data?.user?.addresses?[0].address ?? '';
                        }
                      }

                      return addressList.isNotEmpty
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
                                        Navigator.pushNamed(context,
                                            ShippingAddressPage.routeName);
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
                                    text: address ,
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
                                        Navigator.pushNamed(context, ShippingAddressPage.routeName);
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
                                controller: _couponController,
                                autofocus: false,
                                cursorColor: Colors.white,
                                cursorWidth: 0,
                                showCursor: false,
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
                                onChanged: (value) {
                                  setState(() {
                                    _couponController.text = value;
                                  });
                                },
                                onTap: () {
                                  // Navigator.pushNamed(context, OfferScreen.routeName);
                                  _navigateAndDisplaySelection(context);
                                },
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            //apply coupon here
                            var couPon = _couponController.value.text;
                            if (couPon.isNotEmpty) {
                              applyCoupon(context, couPon, orderId);
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 80,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  bottomRight: Radius.circular(15)),
                              color: primaryColor,
                            ),
                            child: const Center(
                                child: MyGoogleText(
                              text: 'Apply',
                              fontSize: 14,
                              fontColor: Colors.white,
                              fontWeight: FontWeight.normal,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Material(
                        child: Checkbox(
                          value: useShopeeinWallet,
                          onChanged: (value) {
                            setState(() {
                              useShopeeinWallet = value ?? false;
                              paymantType = 1;
                            });
                          },
                        ),
                      ),
                      const Text(
                        'Pay Using Shopeein E-Wallet',
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  MyGoogleTextWhitAli(
                    text: 'Your current E-Wallet balance is ₹$walletBalance',
                    fontSize: 14,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),
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
                          //const PaymentMethodScreen().launch(context);
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
                  RadioListTile(
                    title: const Text("Cash on Delivery"),
                    value: "Cash on Delivery",
                    groupValue: gender,
                    onChanged: useShopeeinWallet
                        ? null
                        : (value) {
                            setState(() {
                              paymantType = 0;
                              gender = value.toString();
                            });
                          },
                  ),
                  RadioListTile(
                    title: const Text("Online Payment"),
                    value: "Online Payment",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        paymantType = 1;
                        gender = value.toString();
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  BlocConsumer<MakeOrderBloc, MakeOrderState>(
                    builder: (context, state) {
                      if (state.status == NetworkCallStatusEnum.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Button1(
                        buttonText: 'Pay Now',
                        buttonColor: primaryColor,
                        onPressFunction: () {

                          var payMentType = '';
                          if (paymantType == 0) {
                            payMentType = "COD";
                          } else if (paymantType == 1){
                            payMentType = "ONLINE";
                          }

                          if(addressId.isEmptyOrNull) {
                            Fluttertoast.showToast(
                                msg: "Please add delivery address",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }else if(payMentType.isEmptyOrNull) {
                            Fluttertoast.showToast(
                                msg: "Please select payment type",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          } else{
                            context.read<MakeOrderBloc>().add(
                                MakeOrderRequestEvent(
                                    token: token,
                                    id: orderId,
                                    deliveryAddress: addressId,
                                    paymentType: payMentType,
                                    canUseWallet: useShopeeinWallet));
                          }
                        },
                      );
                    },
                    listener: (context, state) {
                      if (state.status == NetworkCallStatusEnum.loaded) {
                        if (state.orderOtpVerify.paymentTypeRes == "ONLINE") {
                          if (state.orderOtpVerify.isFullWalletPay) {
                            Navigator.pushNamed(context, GiftPage.routeName);
                          } else {
                            createOrder(state.orderOtpVerify.key,
                                state.orderOtpVerify.orderId, '', '');
                          }
                        } else {
                          var request = OrderOtpVerifyRequest(
                            token: token,
                            requestId: state.orderOtpVerify.requestId,
                            orderId: orderId,
                          );
                          Navigator.pushNamed(
                              context, PinCodeVerificationScreen.routeName,
                              arguments: request);
                        }
                      } else if (state.status == NetworkCallStatusEnum.error) {
                        Fluttertoast.showToast(
                            msg: state.error.errMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///_____________Delivery details______________________________
/*  Column(
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
