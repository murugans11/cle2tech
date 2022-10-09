import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:nb_utils/nb_utils.dart';



import '../constants/constants.dart';
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
  int initialValueFromText = 0;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
                  Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.favorite_border,
                                size: 35,
                                color: primaryColor,
                              )),
                            ),
                            onTap: () {},
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.delete,
                                size: 35,
                                color: secondaryColor1,
                              )),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    child: const CartItemsSingleView(),
                    //
                  ),
                  Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(1),

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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.favorite_border,
                                size: 35,
                                color: primaryColor,
                              )),
                            ),
                            onTap: () {},
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                              ),
                              child: const Center(
                                  child: Icon(
                                Icons.delete,
                                size: 35,
                                color: secondaryColor1,
                              )),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    child: const CartItemsSingleView(),
                    //
                  ),
                  const SizedBox(height: 40),
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
                  ),
                  const SizedBox(height: 20),
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
      ),
    );
  }
}

// ignore: must_be_immutable
