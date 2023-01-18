import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import 'gift_screen.dart';

class PaymentValidationPage extends StatefulWidget {

  static const String routeName = "/PaymentValidationPage";

  final String token;
  final String order;
  final String paymentId;
  final String signature;

  PaymentValidationPage(
      {Key? key,
      required this.token,
      required this.order,
      required this.paymentId,
      required this.signature,})
      : super(key: key);

  @override
  _PaymentValidationPageState createState() => _PaymentValidationPageState();
}

class _PaymentValidationPageState extends State<PaymentValidationPage> {

  SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  Future<String> _fetchUserInfo(String token,String order, String paymentId,String signature,) async {
    final tokenValues = await sharedPreferenceHelper.authToken;
    final orderInit = await homeRepository.savePaymentSuccess(tokenValues ?? '', order, paymentId, signature);
    return orderInit;
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
          text: 'Payment Validation',
          fontColor: secondaryColor2,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headline2!,
          textAlign: TextAlign.center,
          child: FutureBuilder<String>(
            future: _fetchUserInfo(widget.token, widget.order ,widget.paymentId, widget.signature),
            // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                Navigator.pushNamed(context, GiftPage.routeName);
                children = <Widget>[
                 /* const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${snapshot.data}'),
                  ),*/
                  Container()
                ];
              } else if (snapshot.hasError) {
                Navigator.pushNamed(context, GiftPage.routeName);
                children = <Widget>[
                 /* const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),*/

                  Container()

                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
