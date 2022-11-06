import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../cubit/cart/cart_list_response_cubit.dart';
import '../cubit/cart/cart_list_response_state.dart';
import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/cart/CartResponse.dart';
import '../widgets/buttons.dart';
import '../widgets/cart_cost_section.dart';
import '../widgets/cart_item_single_view.dart';
import 'check_out_screen.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = "/CartScreen";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List colorCodes = [10, 20, 30];

  var token;
  SharedPreferenceHelper sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();

  @override
  void initState() {
    super.initState();
    // Add the observer.
    //WidgetsBinding.instance.addObserver(this);
    _asyncMethod();
  }

  _asyncMethod() async {
    final tokenValues = await sharedPreferenceHelper.authToken;
    setState(() {
      token = tokenValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token != null) {
      BlocProvider.of<CartListResponseCubit>(context).loadCartList(token);
    }

    return Scaffold(

      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: MyGoogleText(
                text: '2 items',
                fontSize: 16,
                fontColor: secondaryColor2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
        /*leading: GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
            bottomNavigationBarActions[_selectedIndex].launch(context, isNewTask: true);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),*/
        title: const MyGoogleText(
          text: 'Cart',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),

      body: token == null
          ? const Center(
              child: Text('CartList is empty'),
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children: [

                const SizedBox(height: 10),

                _postList(),

                Container(
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

                      /*Container(
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
                                  color: secondaryColor1),
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
                    ),*/

                      //const SizedBox(height: 20),

                      const CartCostSection(),

                      Button1(
                          buttonText: 'Check Out',
                          buttonColor: primaryColor,
                          onPressFunction: () {
                            const CheckOutScreen().launch(context);
                          }),
                    ],
                  ),
                ),
              ],
            ),
    );
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

          return  ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(8),
              itemCount: cartListResponse.cartDetails?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {

                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: Key(colorCodes[index].toString()),
                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(30)),
                            ),
                            child: const Center(
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 35,
                                  color: primaryColor,
                                )),
                          ),
                          onTap: () {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: secondaryColor1.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(30)),
                            ),
                            child: const Center(
                                child: Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: secondaryColor1,
                                )),
                          ),
                          onTap: () {
                            setState(() {
                              colorCodes.removeAt(index);
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  child: CartItemsSingleView(
                    index: index,
                  ),
                  //
                );

              });
        });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
