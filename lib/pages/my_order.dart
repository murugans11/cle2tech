import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/app_theme.dart';
import '../constants/constants.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/coupan/coupon_response.dart';
import '../models/my_order/my_order_response.dart';
import '../widgets/my_order_cart_item_single_view.dart';
import 'order_details.dart';



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

      /*body: SingleChildScrollView(

        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: HorizontalList(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentItem = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: currentItem == index
                            ? secondaryColor1
                            : Colors.white,
                        border: Border.all(
                          width: 1,
                          color: secondaryColor3,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                      ),
                      child: MyGoogleText(
                        text: productType[index],
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontColor:
                            currentItem == index ? Colors.white : Colors.black,
                      ),
                    ),
                  );
                },
                itemCount: productType.length,
              ),
            ),
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
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        const OrderDetailsScreen().launch(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: secondaryColor3),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const MyGoogleText(
                              text: 'Order ID: #2156254',
                              fontSize: 16,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  MyGoogleText(
                                    text: 'Items (2)',
                                    fontSize: 16,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  MyGoogleText(
                                    text: 'Total Amount \$76.00',
                                    fontSize: 14,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  MyGoogleText(
                                    text: '12 May, 2022',
                                    fontSize: 16,
                                    fontColor: textColors,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  MyGoogleText(
                                    text: 'Delivered',
                                    fontSize: 14,
                                    fontColor: Colors.green,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),*/

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
