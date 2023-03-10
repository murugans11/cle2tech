
import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:nb_utils/nb_utils.dart';
import '../constants/app_theme.dart';
import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';


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
