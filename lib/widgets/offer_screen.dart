import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/app_theme.dart';
import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/coupan/coupon_response.dart';
import '../models/wishlist/verifywishlist.dart';

class OfferScreen extends StatefulWidget {
  static const String routeName = "/OfferScreen";

  const OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future<CouponResponse> _getLatest() async {
    SharedPreferenceHelper sharedPreferenceHelper =
        getIt<SharedPreferenceHelper>();
    HomeRepository homeRepository = getIt<HomeRepository>();
    CouponResponse response = CouponResponse();

    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.getCouPonList(token);
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
            Navigator.pop(context, null);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const MyGoogleText(
          text: 'Choose a coupon code',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
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
                  FutureBuilder<CouponResponse>(
                    future: _getLatest(),
                    builder: (BuildContext context, AsyncSnapshot<CouponResponse> snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              shrinkWrap: true,
                              //physics: const ClampingScrollPhysics(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.coupon?.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            AppTheme.of(context)
                                                    ?.assets
                                                    .logo1 ??
                                                '',
                                          ),
                                          fit: BoxFit.fitWidth),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                  title: MyGoogleText(
                                    text: snapshot
                                            .data?.coupon?[index].couponCode ??
                                        '',
                                    fontColor: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  subtitle: MyGoogleText(
                                    text:
                                        "Get ${snapshot.data?.coupon?[index].discount ?? ''}% OFF On Total Order Amount.",
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                  onTap: () {
                                    Navigator.pop(context, snapshot.data?.coupon?[index].couponCode);
                                  },
                                );
                              },
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
