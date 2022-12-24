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
      ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 10),

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
                  itemCount: snapshot.data?.gift?.length ,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) {

                    return getItem(snapshot.data?.orderGift,snapshot.data?.gift, index, context);
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

        ],
      ),



    );
  }


  GiftGreedView getItem( List<OrderGift>? orderGift,List<Gift>? gift, int index, BuildContext context) {


    bool isClaim1 = false;
    bool isOpen1 = false;
    String imageurl = '';
    var id = gift?[index].id;
    orderGift?.forEach((element) {

      if(element.giftId == id){
        isClaim1 = element.isClaim ?? false;
        isOpen1 = element.isOpen ?? false;
        if(!isClaim1 && !isOpen1){
         // imageurl = gift?[index].resourcePath ?? '';
        }
      }
    });
    return GiftGreedView(
      productTitle: "",
      isSingleView: false,
      callCat: () {
        if(!isClaim1){
          Navigator.pushNamed(context, GiftDetailPage.routeName, arguments: gift?[index]);
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
      imageurl:imageurl ,

    );
  }



  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
