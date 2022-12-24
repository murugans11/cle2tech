import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';

import '../models/wishlist/verifywishlist.dart';
import '../utils/device/custom_error.dart';
import '../widgets/add_new_address.dart';
import '../widgets/buttons.dart';
import '../widgets/confirmation_popup.dart';
import '../widgets/error_dialog.dart';

class ShippingGiftAddressPage extends StatefulWidget {
  static const String routeName = "/ShippingGiftAddressPage";

  const ShippingGiftAddressPage({
    required this.claimType,
    required this.giftId,
    Key? key,
  }) : super(key: key);

  final String claimType;
  final String? giftId;

  @override
  State<ShippingGiftAddressPage> createState() =>
      _ShippingGiftAddressPageState();
}

class _ShippingGiftAddressPageState extends State<ShippingGiftAddressPage> {

  int checked = 0;
  var token;
  bool _isLoaderVisible = false;
  String? deliveryAddress = '';

  SharedPreferenceHelper sharedPreferenceHelper = getIt<
      SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  Future<VerifyWishlist> _getLatest() async {VerifyWishlist response = VerifyWishlist();

    token = await sharedPreferenceHelper.authToken ?? '';
    if (token != null) {
      response = await homeRepository.verifyWishList(token);
    }
    return response;
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewAddress()),
    );
    if (!mounted) return;
    if (result == "save") {
      Navigator.popAndPushNamed(context, ShippingGiftAddressPage.routeName);
    }
  }

  FutureOr<void> _updateGift() async {
    try {
      final response = await homeRepository.updateGift(token, widget.giftId ?? '', deliveryAddress ?? '', widget.claimType,);
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
    } on CustomError catch (e) {
      errorDialog(context, e.errMsg);
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoaderVisible) {
      context.loaderOverlay.hide();
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
            text: 'Shipping Address',
            fontColor: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        body: ListView(children: [
          const SizedBox(
            height: 20,
          ),
          Button1(
              buttonText: 'Add New Address',
              buttonColor: primaryColor,
              onPressFunction: () {
                _navigateAndDisplaySelection(context);
              }),
          FutureBuilder<VerifyWishlist>(
            future: _getLatest(),
            builder: (BuildContext context, AsyncSnapshot<VerifyWishlist> snapshot) {

              if(snapshot.hasData){
                deliveryAddress  = snapshot.data?.user?.addresses?[0].addressId;
              }

              return snapshot.hasData
                  ? ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: snapshot.data?.user?.addresses?.length,
                itemBuilder: (context, index) {
                  return Container(
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: secondaryColor3),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15)),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyGoogleText(
                                      text: snapshot
                                          .data
                                          ?.user
                                          ?.addresses?[index]
                                          .firstName ??
                                          '',
                                      fontSize: 16,
                                      fontColor: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const MyGoogleText(
                                        text: '',
                                        fontSize: 16,
                                        fontColor: secondaryColor1,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  ],
                                ),
                                Flexible(
                                  child: MyGoogleText(
                                    text: snapshot.data?.user
                                        ?.addresses?[index].address ??
                                        '',
                                    fontSize: 16,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                checked == index ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checked = index;
                                        deliveryAddress  = snapshot.data?.user?.addresses?[index].addressId;
                                      });
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.check_box,
                                          color: primaryColor,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        MyGoogleText(
                                          text:
                                          'Use as the shipping address',
                                          fontSize: 16,
                                          fontColor: Colors.black,
                                          fontWeight:
                                          FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                    : Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checked = index;
                                        deliveryAddress  = snapshot.data?.user?.addresses?[index].addressId;
                                      });
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons
                                              .check_box_outline_blank,
                                          color: textColors,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        MyGoogleText(
                                          text:
                                          'Use as the shipping address',
                                          fontSize: 16,
                                          fontColor: textColors,
                                          fontWeight:
                                          FontWeight.normal,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading data from API...'),
                    )
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Button1(
              buttonText: 'Proceed',
              buttonColor: primaryColor,
              onPressFunction: () {
                setState(() {
                  _isLoaderVisible = context.loaderOverlay.visible;
                });

                _updateGift();

                if (_isLoaderVisible) {
                  context.loaderOverlay.hide();
                }
              }),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
