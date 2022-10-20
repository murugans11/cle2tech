import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/models/categoriesbyname/categorieItems.dart';
import 'package:shopeein/models/feature/feature_productes.dart';
import '../blocs/categoriesIitembyname/categories_items_by_name_bloc.dart';
import '../constants/constants.dart';
import '../data/network/constants/endpoints.dart';
import '../widgets/filter_widget.dart';
import '../widgets/product_greed_view_widget.dart';
import '../widgets/sort_widget.dart';
import 'product_detail_screen.dart';

class SingleCategoryScreen extends StatefulWidget {
  static const String routeName = "/SingleCategoryScreen";

  const SingleCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  var currentItem = 0;
  final productType = ['All', 'Dresses', 'Shoes', 'T-shirts', 'Tops', 'Pants'];

  bool isSingleView = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    CategoryItemDisplay categoryItemDisplay = ModalRoute.of(context)!.settings.arguments as CategoryItemDisplay;
    /*&sort=price_asc*/
    if (categoryItemDisplay.path != 'null') {
      final splitNames =  categoryItemDisplay.path?.split('/');
      List splitList = [];
      splitNames?.forEach((element) {
        splitList.add(element);
      });
      final query = splitList.last;
      var url = '${Endpoints.getViewAllCategoryProductList}/$query/?page=1';
      context.read<CategoriesItemsByNameBloc>().add(FetchCategoriesItemsByNameEvent(url: url));
    } else {
      var url = '${Endpoints.getCategoryProductListByName}/${categoryItemDisplay.name}/?page=1';
      context.read<CategoriesItemsByNameBloc>().add(FetchCategoriesItemsByNameEvent(url: url));
    }

    return Scaffold(
      //backgroundColor: primaryColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: secondaryColor2,
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
            color: Colors.white,
          ),
        ),
        title: MyGoogleText(
          text: categoryItemDisplay.displayName ?? '',
          fontColor: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///__________filter ToolBar________________________________________________
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ///____________Sort Section________________________________________________
                TextButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        context: context,
                        builder: (context) => const Sort());
                  },
                  child: Row(
                    children: const [
                      Icon(
                        FeatherIcons.sliders,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      MyGoogleText(
                        text: 'Sort',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),

                ///____________Filter Section____________________________________________
                TextButton(
                  onPressed: () {
                    showMaterialModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        context: context,
                        builder: (context) => const Filter());
                  },
                  child: Row(
                    children: const [
                      Icon(
                        IconlyLight.filter,
                        color: Colors.black,
                      ),
                      SizedBox(width: 5),
                      MyGoogleText(
                        text: 'Filter',
                        fontSize: 16,
                        fontColor: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSingleView = false;
                        });
                      },
                      icon: isSingleView
                          ? const Icon(
                              IconlyLight.category,
                              color: textColors,
                            )
                          : const Icon(
                              IconlyLight.category,
                              color: Colors.black,
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isSingleView = true;
                        });
                      },
                      icon: isSingleView
                          ? const Icon(
                              Icons.rectangle_outlined,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.rectangle_outlined,
                              color: textColors,
                            ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<CategoriesItemsByNameBloc,
                CategoriesItemsByNameInitial>(
              builder: (context, state) {
                return Container(
                  padding: isSingleView
                      ? const EdgeInsets.all(40)
                      : const EdgeInsets.only(
                          left: 20, top: 20, bottom: 20, right: 10),
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
                      /*  HorizontalList(
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
                      ),*/
                      isSingleView
                          ? GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.90,
                              ),
                              itemCount:
                                  state.categorieItems.listingProduct?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return getItem(
                                    state.categorieItems.listingProduct,
                                    index,
                                    context);
                              },
                            )
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.55,
                              ),
                              itemCount:
                                  state.categorieItems.listingProduct?.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return getItem(
                                    state.categorieItems.listingProduct,
                                    index,
                                    context);
                              },
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  ProductGreedShow1 getItem(List<ListingProduct>? listingProductList, int index,
      BuildContext context) {
    String imageURL = '';
    var parts = listingProductList?[index]
        .keyDetails
        ?.variant?[0]
        .media?[0]
        .resourcePath
        .split('.com');
    if (parts != null) {
      var image = parts.sublist(1).join('.com').trim();
      imageURL =
          'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/500x500/filters:format(png)/$image';
    }
    final sellingPrice =
        listingProductList?[index].keyDetails?.variant?[0].sellingPrice;
    final retailPrice =
        listingProductList?[index].keyDetails?.variant?[0].retailPrice;
    int percent = ((int.parse(retailPrice) - int.parse(sellingPrice)) /
            int.parse(retailPrice) *
            100)
        .toInt();
    return ProductGreedShow1(
      image: imageURL,
      productTitle: listingProductList?[index].keyDetails?.productTitle,
      productPrice: sellingPrice,
      actualPrice: retailPrice,
      discountPercentage: ("-$percent%"),
      isSingleView: false,
      callCat: () {
        Navigator.pushNamed(context, ProductDetailScreen.routeName,
            arguments: listingProductList?[index]);
      },
    );
  }
}
