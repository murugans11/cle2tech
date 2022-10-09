import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/constants.dart';
import '../widgets/filter_tool_bar.dart';
import '../widgets/product_greed_view_widget1.dart';




class SingleCategoryScreen extends StatefulWidget {
  const SingleCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  var currentItem = 0;
  final productType = ['All', 'Dresses', 'Shoes', 'T-shirts', 'Tops', 'Pants'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: primaryColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: secondaryColor3,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  FeatherIcons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const MyGoogleText(
          text: 'Women',
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FilterToolBar(),
            const SizedBox(height: 20),
            Container(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
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
                    HorizontalList(
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
                                  ? primaryColor
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
                              fontColor: currentItem == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        );
                      },
                      itemCount: productType.length,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 0.55,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext ctx, index) {
                        return const ProductGreedShow(
                          image: 'images/woman.png',
                          productTitle: 'Blazer Trousers Suit',
                          productPrice: '33.30',
                          discountPercentage: '-30%',
                          isSingleView: false,
                        );
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
