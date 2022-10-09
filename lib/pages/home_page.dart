import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/blocs/banner/bannerList_event.dart';
import 'package:shopeein/blocs/banner/bannerList_state.dart';
import 'package:shopeein/constants/app_theme.dart';
import 'package:shopeein/models/feature/feature_productes.dart';
import 'package:shopeein/pages/single_category_screen.dart';

import '../blocs/banner/bannarList_bloc.dart';
import '../blocs/category/categoryList_bloc.dart';
import '../blocs/featureproduct/feature_product_list_bloc.dart';
import '../constants/constants.dart';

import '../utils/dio/network_call_status_enum.dart';
import '../widgets/app_widgets.dart';
import '../widgets/error_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/notificition_screen.dart';
import '../widgets/product_greed_view_widget.dart';
import '../widgets/product_greed_view_widget1.dart';
import 'best_seller_screen.dart';
import 'category_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(const FetchCategoriesItemsEvent());
    context.read<BannerBloc>().add(const FetchBannerItemsEvent());
    context
        .read<FeatureProductListBloc>()
        .add(const FetchFeatureProductItemsEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: MyGoogleText(
          text: AppTheme.of(context)?.values.appName ?? '',
          fontSize: 20,
          fontColor: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () {
              //const ProfileScreen().launch(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Image(
                  image: AssetImage(
                    AppTheme.of(context)?.assets.logo1 ?? '',
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ),
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
                onPressed: () {
                  //const SearchProductScreen().launch(context);
                },
                icon: const Icon(
                  FeatherIcons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
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
                onPressed: () {
                  const NotificationsScreen().launch(context);
                },
                icon: const Icon(
                  FeatherIcons.bell,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: ListView(
        children: [
          BlocBuilder<BannerBloc, BannerState>(
            builder: (context, state) {
              return HorizontalList(
                padding: const EdgeInsets.all(10),
                itemCount: state.bannerList.categoryGroup?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      debugPrint(
                          "Category Item click${state.bannerList.categoryGroup?[index].resourcePath}");
                    },
                    child: Container(
                      height: 190,
                      width: 310,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: FittedBox(
                        child: Image(
                          image: NetworkImage(state.bannerList
                                  .categoryGroup?[index].resourcePath ??
                              ''),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 15),
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
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyGoogleText(
                          text: 'Categories',
                          fontSize: 16,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        TextButton(
                          onPressed: () {
                            const CategoryScreen().launch(context);
                          },
                          child: const MyGoogleText(
                            text: 'Show All',
                            fontSize: 13,
                            fontColor: textColors,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    BlocConsumer<CategoriesBloc, CategoryState>(
                      listener: (context, state) {
                        if (state.status == NetworkCallStatusEnum.error) {
                          errorDialog(context, state.error.errMsg);
                        }
                      },
                      builder: (context, state) {
                        return HorizontalList(
                          spacing: 20,
                          itemCount: state.categoryList.categoryGroup!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    const SingleCategoryScreen()
                                        .launch(context);
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(state.categoryList
                                            .categoryGroup![index].image),
                                        fit: BoxFit.fitHeight,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      border: Border.all(
                                        width: 1,
                                        color: secondaryColor3,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyGoogleText(
                                  text: state.categoryList.categoryGroup?[index]
                                          .title ??
                                      '',
                                  fontSize: 13,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    _showFeatureList()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showFeatureList() {
    return BlocConsumer<FeatureProductListBloc, FeatureProductListState>(
      listener: (context, state) {
        if (state.status == NetworkCallStatusEnum.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        if (state.status == NetworkCallStatusEnum.error) {
          return const Center(
            child: Text(
              'Something went wrong!',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.status == NetworkCallStatusEnum.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == NetworkCallStatusEnum.loaded) {
          return _buildListView(state, context);
        }

        return Container();
      },
    );
  }

  Widget _buildListView(FeatureProductListState state, BuildContext context) {
    return ListView.builder(
      // inner ListView
      shrinkWrap: true, // 1st add
      physics: const ClampingScrollPhysics(), // 2nd add
      itemCount: state.featureProductList.featureProduct?.length ?? 0,
      itemBuilder: (_, mainIndex) {
        List<ListingProduct>? listingProduct = [];
        state.featureProductList.featureProduct?[mainIndex].listing
            ?.forEach((element1) {
          state.featureProductList.listingProduct?.forEach((element) {
            String image =
                element.keyDetails?.variant?[0].media?[0].resourcePath;
            if (element.id == element1 && !image.isEmptyOrNull) {
              listingProduct.add(element);
              return;
            }
          });
        });

        return Column(
          children: [
            getItemTitle(
                state.featureProductList.featureProduct?[mainIndex].title),
            HorizontalList(
              spacing: 20,
              itemCount: listingProduct.length,
              itemBuilder: (BuildContext context, int index) {
                ListingProduct? listingProductItems = listingProduct[index];

                String imageURL = '';
                var parts = listingProductItems
                    .keyDetails?.variant?[0].media?[0].resourcePath
                    .split('.com');
                if (parts != null) {
                  var image = parts.sublist(1).join('.com').trim();
                  imageURL =
                      'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/500x500/filters:format(png)/$image';
                }
                // double percent=(listingProductItems.keyDetails?.variant?[0].retailPrice - listingProductItems.keyDetails?.variant?[0].sellingPrice)/listingProductItems.keyDetails?.variant?[0].retailPrice*100;
                return ProductGreedShow1(
                  image: imageURL,
                  productTitle: listingProductItems.keyDetails?.productTitle,
                  productPrice:
                      listingProductItems.keyDetails?.variant?[0].sellingPrice,
                  discountPercentage: ("10%"),
                  isSingleView: false,
                  callCat: () {
                    debugPrint('productTitle${listingProductItems.keyDetails?.productTitle}');

                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget productCard(
    Function callCat,
    FeatureProductListState state,
    int mainIndex,
    int subIndex,
  ) {
    ListingProduct? listingProductItems;
    var mainId =
        state.featureProductList.featureProduct?[mainIndex].listing?[subIndex];
    state.featureProductList.listingProduct?.forEach((element) {
      if (element.id == mainId) {
        listingProductItems = element;
        return;
      }
    });
    String imageURL = '';
    var parts = listingProductItems
        ?.keyDetails?.variant?[0].media?[0].resourcePath
        .split('.com');
    if (parts != null) {
      var image = parts.sublist(1).join('.com').trim();
      imageURL =
          'https://dvlt0mtg4c3zr.cloudfront.net/fit-in/500x500/filters:format(png)/$image';
      return InkWell(
        onTap: () {
          callCat;
        },
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: imageURL.isEmpty ? '' : imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                // placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(
                width: 150.0,
                child: Text(
                  listingProductItems?.keyDetails?.productTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: AppTheme.of(context)?.textStyles.kBordStyleIndexText,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '\u{20B9}${2500}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    TextSpan(
                      text: '\u{20B9}${6000}',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '${40}% off',
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  Widget getItemTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyGoogleText(
          text: title,
          fontSize: 16,
          fontColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        TextButton(
          onPressed: () {
            const BestSellerScreen().launch(context);
          },
          child: const MyGoogleText(
            text: 'Show All',
            fontSize: 13,
            fontColor: textColors,
            fontWeight: FontWeight.normal,
          ),
        )
      ],
    );
  }

  Widget headText(String? title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              title ?? '',
              style: AppTheme.of(context)?.textStyles.kBordStyle,
            ),
          ),
          Container(
            decoration: boxDecoration(
                bgColor: AppTheme.of(context)?.colors.mPrimaryColor,
                radius: 2.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "View All",
                style: TextStyle(
                    color: AppTheme.of(context)?.colors.mBackgroundColor,
                    fontSize: 12.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
