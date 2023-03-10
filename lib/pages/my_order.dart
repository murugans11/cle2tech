import 'package:flutter/material.dart'hide ModalBottomSheetRoute;

import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';

import '../models/my_order/my_order_response.dart';
import '../widgets/my_order_cart_item_single_view.dart';




class MyOrderScreen extends StatefulWidget {

  static const String routeName = "/MyOrderScreen";

  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {

  var currentItem = 0;
  final productType = [
    'All Order',
    'Processing',
    'Delivery',
    'Cancel Order',
    'Tops',
    'Pants'
  ];

  var token;

  SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  Future<MyOrderResponse> _getLatest() async {
    MyOrderResponse response = MyOrderResponse();
    token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.getMyOrders(token);
    }
    return response;
  }

  _asyncMethod() async {
    final tokenValues = await sharedPreferenceHelper.authToken;
    setState(() {
      token = tokenValues;
    });
  }

  @override
  void initState() {
    super.initState();
    _asyncMethod();
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
          text: 'My Order',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),


      body: token == null
          ? const Center(
        child: Text('CartList is empty'),
      ) :
      ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10),
          FutureBuilder<MyOrderResponse>(
            future: _getLatest(),
            builder: (BuildContext context, AsyncSnapshot<MyOrderResponse> snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                shrinkWrap: true,
                //physics: const ClampingScrollPhysics(),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.listing?.length,
                itemBuilder: (context, index) {


                  String qty = snapshot.data?.listing?[index].qty.toString() ?? '';

                  String imageURL = '';
                  var parts = snapshot.data?.listing?[index].resourcePath?.resourcePath
                      ?.split('.com');
                  if (parts != null) {
                    var image = parts.sublist(1).join('.com').trim();
                    imageURL =
                    'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/500x500/filters:format(png)/$image';
                  }

                  String sellingPrice = snapshot.data?.listing?[index].sellingPrice.toString() ?? '0';

                  String retailPrice = snapshot.data?.listing?[index].retailPrice.toString() ?? '0';

                  String mrp = snapshot.data?.listing?[index].mrp.toString() ?? '0';

                  int percentage = ((int.parse(mrp) - int.parse(sellingPrice)) / int.parse(mrp) * 100).toInt();

                  String productTitle = snapshot.data?.listing?[index].productTitle ?? '';

                  final optionalAttributes = snapshot.data?.listing?[index].optionalAttributes;

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

                  return MyOrderCartItemsSingleView(
                      resourcePath: imageURL,
                      productTitle: productTitle,
                      displayColourName: displayColourName,
                      displaySizeName: displaySizeName,
                      sellingPrice: sellingPrice,
                      mrp: mrp,
                      percentage: percentage,
                      qty: qty,
                  );
                },
              ) : Center(
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



    );
  }
}
