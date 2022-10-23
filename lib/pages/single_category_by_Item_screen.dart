import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/product_detail_screen.dart';

import '../constants/constants.dart';

import '../cubit/category_group_cubit.dart';
import '../cubit/single_category_items_cubit.dart';
import '../cubit/single_category_items_state.dart';
import '../data/network/constants/endpoints.dart';
import '../models/categoriesbyname/categorieItems.dart';
import '../models/feature/feature_productes.dart';
import '../widgets/product_greed_view_widget.dart';

class SingleCategoryByItemScreen extends StatefulWidget {
  static const String routeName = "/SingleCategoryByItemScreen";

  const SingleCategoryByItemScreen({super.key});

  @override
  State<SingleCategoryByItemScreen> createState() => _SingleCategoryByItemScreenState();
}

class _SingleCategoryByItemScreenState extends State<SingleCategoryByItemScreen> {

  final scrollController = ScrollController();

  int page = 1;

  void setupScrollController(context, CategoryItemDisplay categoryItemDisplay) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          getUrl(categoryItemDisplay, context);
        }
      }
    });
  }

  void getUrl(CategoryItemDisplay categoryItemDisplay, context) {
    if (categoryItemDisplay.path != 'null') {
      final splitNames = categoryItemDisplay.path?.split('/');
      List splitList = [];
      splitNames?.forEach((element) {
        splitList.add(element);
      });
      final query = splitList.last;
      var url = '${Endpoints.getSingleItemListFromCategory}/$query/?page=';
      BlocProvider.of<SingleCategoryCubit>(context).loadSingleCategory(url, page);
    };
  }



  @override
  Widget build(BuildContext context) {

    CategoryItemDisplay categoryItemDisplay = ModalRoute.of(context)!.settings.arguments as CategoryItemDisplay;
    getUrl(categoryItemDisplay, context);
    setupScrollController(context, categoryItemDisplay);


    return Scaffold(
      //backgroundColor: primaryColor.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        /*actions: [
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
        ],*/
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

      body: Column(
        children: [
          Expanded(child: _postList()),
        ],
      ),
    );
  }

  Widget _postList() {
    return BlocBuilder<SingleCategoryCubit, SingleCategoryItemState>(
        builder: (context, state) {
      if (state is SingleCategoryLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      CategorieItems categoryItems = CategorieItems(listingProduct: []);
      bool isLoading = false;

      if (state is SingleCategoryLoading) {
        categoryItems = state.oldPosts;
        isLoading = true;
      } else if (state is SingleCategoryLoaded) {
        categoryItems = state.posts;
        page++;
      }

      return Container(
        padding:
            const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: categoryItems.listingProduct.length + (isLoading ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) {
            if (index < categoryItems.listingProduct.length) {
              // return _post(posts[index], context);
              return getItem(categoryItems.listingProduct, index, context);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return _loadingIndicator();
            }
          },
        ),
      );
    });
  }

  ProductGreedShow1 getItem(List<ListingProduct>? listingProductList, int index, BuildContext context) {
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
        Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: listingProductList?[index]);
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
