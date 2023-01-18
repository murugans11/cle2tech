import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/product_detail_screen.dart';

import '../constants/constants.dart';


import '../cubit/cart/single_category_group/single_category_items_cubit.dart';

import '../cubit/cart/single_category_group/single_category_items_state.dart';
import '../data/network/constants/endpoints.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/categoriesbyname/categorieItems.dart';
import '../models/feature/feature_productes.dart';
import '../models/gift/GiftDetailRequest.dart';
import '../models/gift/gift_response.dart';
import '../models/wishlist/verifywishlist.dart';
import '../widgets/gift_greed_view_widget.dart';
import '../widgets/product_greed_view_widget.dart';
import 'auth_screen/log_in_screen.dart';
import 'gift_detail_screen.dart';

class GiftPage extends StatefulWidget {

  static const String routeName = "/GiftPage";

  const GiftPage({super.key});

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {

  SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();
  var token;

  Future<GiftResponse> _getLatest() async {

    GiftResponse response = GiftResponse();
    token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.getMyGift(token);
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
          text: 'Gift',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 20,
        ),
      ),


      body: token == null
          ? const Center(
        child: Text('MyGift is empty'),
      ) :
      FutureBuilder<GiftResponse>(
            future: _getLatest(),
            builder: (BuildContext context, AsyncSnapshot<GiftResponse> snapshot) {
              return snapshot.hasData ? Container(padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
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
                  itemCount: snapshot.data?.orderGift?.length ,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {

                    return GestureDetector(
                        onTap: () {

                          bool? isClaim1 = snapshot.data?.orderGift?[index].isClaim;;

                          if(!isClaim1!) {

                            String imageurl = '';

                            var giftId = snapshot.data?.orderGift?[index].giftId;

                            snapshot.data?.gift?.forEach((element) {
                              if(element.id == giftId){
                                imageurl = element.resourcePath ?? '';
                              }
                            });
                            var arg = GiftDetailRequest(requestPath: imageurl, orderId: giftId?? '');
                            Navigator.pushNamed(context, GiftDetailPage.routeName, arguments: arg);

                          }else{
                            Fluttertoast.showToast(
                                msg: "Gift already claimed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }

                        },
                        child: getItem(snapshot.data?.orderGift,snapshot.data?.gift, index, context)
                    );
                  },
                ),
              ) : Center(child: Column(
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
                ),);
            },
          ),

    );
  }


  GiftGreedView getItem( List<OrderGift>? orderGift, List<Gift>? gift, int index, BuildContext context) {


    String imageurl = '';
    var giftId = orderGift?[index].giftId;
    gift?.forEach((element) {
      if(element.id == giftId){
        bool? claim = orderGift?[index].isClaim;
        bool? open = orderGift?[index].isOpen;
        if(claim! && open!) {
           imageurl = element.resourcePath ?? '';
        }
      }
    });

    return GiftGreedView(
      productTitle: "",
      isSingleView: false,
      imageurl:imageurl ,

    );
  }


}
