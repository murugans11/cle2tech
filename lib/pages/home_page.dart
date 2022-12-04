import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/blocs/banner/bannerList_event.dart';
import 'package:shopeein/blocs/banner/bannerList_state.dart';
import 'package:shopeein/constants/app_theme.dart';
import 'package:shopeein/models/feature/feature_productes.dart';
import 'package:shopeein/pages/initial_page.dart';
import 'package:shopeein/pages/product_detail_screen.dart';
import 'package:shopeein/pages/single_category_by_Item_screen.dart';
import 'package:shopeein/pages/single_category_group_screen.dart';
import 'package:shopeein/pages/splash_screen_one.dart';

import '../blocs/banner/bannarList_bloc.dart';
import '../blocs/category_groupe/categoryList_bloc.dart';
import '../blocs/featureproduct/feature_product_list_bloc.dart';
import '../constants/constants.dart';

import '../data/repository/home_repository.dart';
import '../data/sharedpref/shared_preference_helper.dart';
import '../di/components/service_locator.dart';
import '../models/banner/banner_list.dart';
import '../models/categoriesbyname/categorieItems.dart';
import '../models/wishlist/verifywishlist.dart';
import '../utils/dio/network_call_status_enum.dart';
import '../widgets/error_dialog.dart';

import '../widgets/notificition_screen.dart';
import '../widgets/product_greed_view_widget.dart';
import 'auth_screen/log_in_screen.dart';
import 'best_seller_screen.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<BannerGroup>? categoryGroup = [];

  SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  HomeRepository homeRepository = getIt<HomeRepository>();
  VerifyWishlist response = VerifyWishlist();

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    context.read<CategoriesBloc>().add(const FetchCategoriesItemsEvent());
    context.read<BannerBloc>().add(const FetchBannerItemsEvent());
    context.read<FeatureProductListBloc>().add(const FetchFeatureProductItemsEvent());
  }

  _asyncMethod() async {
    var token = await sharedPreferenceHelper.authToken;
    if (token != null) {
      response = await homeRepository.verifyWishList(token);
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        title: Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            AppTheme.of(context)?.assets.logo2 ?? '',
            height: 90.0,
            width: 130.0,
          ),
        ),

        /*leading: Padding(
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
        ),*/

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
          const SizedBox(height: 10),

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
                          categoriesItemsClick(state, index, context);
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(state
                                  .categoryList.categoryGroup![index].image),
                              fit: BoxFit.fitHeight,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
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
                        text: state.categoryList.categoryGroup?[index].title ??
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

          const SizedBox(height: 10),

          _createBannerItems(),

          const SizedBox(height: 5),

          Container(
              padding: const EdgeInsets.only(left: 15, top: 15),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(1),
                  topLeft: Radius.circular(1),
                ),
              ),
              child: Column(
                children: [_showFeatureList()],
              )),
        ],
      ),
    );
  }

  Widget _createBannerItems() {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        List<BannerGroup>? bannerMobile = [];
        state.bannerList.categoryGroup?.forEach((element) {
          if (element.bannerType == "mobile") {
            bannerMobile.add(element);
          } else {
            categoryGroup?.add(element);
          }
        });

        return Card(
          shadowColor: Colors.grey,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              aspectRatio: 2.0,
              enableInfiniteScroll: false,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
            ),
            items: bannerMobile.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      for (int j = 0; j < bannerMobile.length; j++) {
                        if (i.resourcePath == bannerMobile[j].resourcePath) {
                          bannerItemClick(bannerMobile, j, context);
                        }
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(color: Colors.amber),
                      child: CachedNetworkImage(
                        imageUrl: i.resourcePath,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void bannerItemClick(
      List<BannerGroup> bannerMobile, int index, BuildContext context) {
    final splitNames = bannerMobile[index].link?.split('/');
    List splitList = [];
    splitNames?.forEach((element) {
      splitList.add(element);
    });
    final name = splitList.last;
    final category = CategoryItemDisplay(
      name: name,
      displayName: name,
      path: bannerMobile[index].link,
      categorieItemList: null,
    );
    Navigator.pushNamed(context, SingleCategoryByItemScreen.routeName,
        arguments: category);
  }

  void categoriesItemsClick(
      CategoryState state, int index, BuildContext context) {
    //Get the getegory item path last name
    final splitNames =
        state.categoryList.categoryGroup![index].path?.split('/');
    List splitList = [];
    splitNames?.forEach((element) {
      splitList.add(element);
    });
    final query = splitList.last;

    List<Category1> categoryList = [];
    for (var element in state.categoryList.categoryGroup![index].category) {
      List e1 = element;
      for (var element1 in e1) {
        categoryList.add(
          Category1(
            name: element1['name'],
            displayName: element1['displayName'],
            path: element1['path'],
          ),
        );
      }
    }

    final category = CategoryItemDisplay(
      name: query,
      displayName: state.categoryList.categoryGroup![index].title,
      path: 'null',
      categorieItemList: categoryList,
    );

    Navigator.pushNamed(context, SingleCategoryGroupScreen.routeName,
        arguments: category);
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

        /* if (state.status == NetworkCallStatusEnum.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }*/

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

        if (mainIndex == 1) {
          List<BannerGroup> bannerFeature1 = [];
          categoryGroup?.forEach((element) {
            if (element.bannerType == "feature1") {
              if (!bannerFeature1.contains(element)) {
                bannerFeature1.add(element);
              }
            }
          });
          return Column(
            children: [
              const SizedBox(height: 10),
              subBanner(bannerFeature1),
              getItemTitle(state, mainIndex),
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

                  final sellingPrice =
                      listingProductItems.keyDetails?.variant?[0].sellingPrice;

                  final retailPrice =
                      listingProductItems.keyDetails?.variant?[0].retailPrice;

                  int percent =
                      ((int.parse(retailPrice) - int.parse(sellingPrice)) /
                              int.parse(retailPrice) *
                              100)
                          .toInt();

                  final productId = listingProductItems.id;
                  final sku = listingProductItems.keyDetails?.variant?[0].sku;

                  return ProductGreedShow1(
                    image: imageURL,
                    productTitle: listingProductItems.keyDetails?.productTitle,
                    productPrice: sellingPrice,
                    actualPrice: retailPrice,
                    discountPercentage: ("-$percent%"),
                    isSingleView: false,
                    callCat: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: listingProductItems);
                    },
                    navToLogin: () {
                      _navigateAndDisplaySelection(context);
                    },
                    productId: productId,
                    sku: sku,
                    response: response,
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          );
        } else if (mainIndex == 3) {
          List<BannerGroup> bannerFeature2 = [];
          categoryGroup?.forEach((element) {
            if (element.bannerType == "feature2") {
              if (!bannerFeature2.contains(element)) {
                bannerFeature2.add(element);
              }
            }
          });
          return Column(
            children: [
              const SizedBox(height: 10),
              subBanner(bannerFeature2),
              const SizedBox(height: 20),
              getItemTitle(state, mainIndex),
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
                  final sellingPrice =
                      listingProductItems.keyDetails?.variant?[0].sellingPrice;
                  final retailPrice =
                      listingProductItems.keyDetails?.variant?[0].retailPrice;
                  int percent =
                      ((int.parse(retailPrice) - int.parse(sellingPrice)) /
                              int.parse(retailPrice) *
                              100)
                          .toInt();

                  final productId = listingProductItems.id;
                  final sku = listingProductItems.keyDetails?.variant?[0].sku;
                  return ProductGreedShow1(
                    image: imageURL,
                    productTitle: listingProductItems.keyDetails?.productTitle,
                    productPrice: sellingPrice,
                    actualPrice: retailPrice,
                    discountPercentage: ("-$percent%"),
                    isSingleView: false,
                    callCat: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: listingProductItems);
                    },
                    navToLogin: () {
                      _navigateAndDisplaySelection(context);
                    },
                    productId: productId,
                    sku: sku,
                    response: response,
                  );
                },
              ),
            ],
          );
        } else if (mainIndex == 5) {
          List<BannerGroup> bannerFeature3 = [];
          categoryGroup?.forEach((element) {
            if (element.bannerType == "feature3") {
              if (!bannerFeature3.contains(element)) {
                bannerFeature3.add(element);
              }
            }
          });
          return Column(
            children: [
              const SizedBox(height: 10),
              subBanner(bannerFeature3),
              const SizedBox(height: 20),
              getItemTitle(state, mainIndex),
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
                  final sellingPrice =
                      listingProductItems.keyDetails?.variant?[0].sellingPrice;
                  final retailPrice =
                      listingProductItems.keyDetails?.variant?[0].retailPrice;
                  int percent =
                      ((int.parse(retailPrice) - int.parse(sellingPrice)) /
                              int.parse(retailPrice) *
                              100)
                          .toInt();
                  final productId = listingProductItems.id;
                  final sku = listingProductItems.keyDetails?.variant?[0].sku;
                  return ProductGreedShow1(
                    image: imageURL,
                    productTitle: listingProductItems.keyDetails?.productTitle,
                    productPrice: sellingPrice,
                    actualPrice: retailPrice,
                    discountPercentage: ("-$percent%"),
                    isSingleView: false,
                    callCat: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: listingProductItems);
                    },
                    navToLogin: () {
                      _navigateAndDisplaySelection(context);
                    },
                    productId: productId,
                    sku: sku,
                    response: response,
                  );
                },
              ),
            ],
          );
        } else if (mainIndex == 7) {
          List<BannerGroup> bannerFeature4 = [];
          categoryGroup?.forEach((element) {
            if (element.bannerType == "feature4") {
              if (!bannerFeature4.contains(element)) {
                bannerFeature4.add(element);
              }
            }
          });
          return Column(
            children: [
              const SizedBox(height: 10),
              subBanner(bannerFeature4),
              const SizedBox(height: 20),
              getItemTitle(state, mainIndex),
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
                  final sellingPrice =
                      listingProductItems.keyDetails?.variant?[0].sellingPrice;
                  final retailPrice =
                      listingProductItems.keyDetails?.variant?[0].retailPrice;
                  int percent =
                      ((int.parse(retailPrice) - int.parse(sellingPrice)) /
                              int.parse(retailPrice) *
                              100)
                          .toInt();
                  final productId = listingProductItems.id;
                  final sku = listingProductItems.keyDetails?.variant?[0].sku;
                  return ProductGreedShow1(
                    image: imageURL,
                    productTitle: listingProductItems.keyDetails?.productTitle,
                    productPrice: sellingPrice,
                    actualPrice: retailPrice,
                    discountPercentage: ("-$percent%"),
                    isSingleView: false,
                    callCat: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: listingProductItems);
                    },
                    navToLogin: () {
                      _navigateAndDisplaySelection(context);
                    },
                    productId: productId,
                    sku: sku,
                    response: response,
                  );
                },
              ),
            ],
          );
        } else if (mainIndex == 9) {
          List<BannerGroup> bannerFeature5 = [];
          categoryGroup?.forEach((element) {
            if (element.bannerType == "feature5") {
              if (!bannerFeature5.contains(element)) {
                bannerFeature5.add(element);
              }
            }
          });
          return Column(
            children: [
              const SizedBox(height: 10),
              subBanner(bannerFeature5),
              const SizedBox(height: 20),
              getItemTitle(state, mainIndex),
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
                  final sellingPrice =
                      listingProductItems.keyDetails?.variant?[0].sellingPrice;
                  final retailPrice =
                      listingProductItems.keyDetails?.variant?[0].retailPrice;
                  int percent =
                      ((int.parse(retailPrice) - int.parse(sellingPrice)) /
                              int.parse(retailPrice) *
                              100)
                          .toInt();
                  final productId = listingProductItems.id;
                  final sku = listingProductItems.keyDetails?.variant?[0].sku;
                  return ProductGreedShow1(
                    image: imageURL,
                    productTitle: listingProductItems.keyDetails?.productTitle,
                    productPrice: sellingPrice,
                    actualPrice: retailPrice,
                    discountPercentage: ("-$percent%"),
                    isSingleView: false,
                    callCat: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: listingProductItems);
                    },
                    navToLogin: () {
                      _navigateAndDisplaySelection(context);
                    },
                    productId: productId,
                    sku: sku,
                    response: response,
                  );
                },
              ),
            ],
          );
        } else {
          return Column(
            children: [
              getItemTitle(state, mainIndex),
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
                  final sellingPrice =
                      listingProductItems.keyDetails?.variant?[0].sellingPrice;
                  final retailPrice =
                      listingProductItems.keyDetails?.variant?[0].retailPrice;
                  int percent =
                      ((int.parse(retailPrice) - int.parse(sellingPrice)) /
                              int.parse(retailPrice) *
                              100)
                          .toInt();
                  final productId = listingProductItems.id;
                  final sku = listingProductItems.keyDetails?.variant?[0].sku;
                  return ProductGreedShow1(
                    image: imageURL,
                    productTitle: listingProductItems.keyDetails?.productTitle,
                    productPrice: sellingPrice,
                    actualPrice: retailPrice,
                    discountPercentage: ("-$percent%"),
                    isSingleView: false,
                    callCat: () {
                      Navigator.pushNamed(
                          context, ProductDetailScreen.routeName,
                          arguments: listingProductItems);
                    },
                    navToLogin: () {
                      _navigateAndDisplaySelection(context);
                    },
                    productId: productId,
                    sku: sku,
                    response: response,
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  // Navigator.pop.
  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LogInScreen()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result != null) {
      setState(() {
      // Navigator.popAndPushNamed(context, HomePage.routeName);
       Navigator.of(context)
           .pushNamedAndRemoveUntil(InitialPage.routeName, (Route<dynamic> route) => false);
      });
    }
  }

  Card subBanner(List<BannerGroup> bannerFeature1) {
    return Card(
      shadowColor: Colors.grey,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 250.0,
          aspectRatio: 2.0,
          enableInfiniteScroll: false,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
        ),
        items: bannerFeature1.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  for (int j = 0; j < bannerFeature1.length; j++) {
                    if (i.resourcePath == bannerFeature1[j].resourcePath) {
                      bannerItemClick(bannerFeature1, j, context);
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: CachedNetworkImage(
                    imageUrl: i.resourcePath,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget getItemTitle(FeatureProductListState state, int mainIndex) {
    String title = state.featureProductList.featureProduct?[mainIndex].title;
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
            debugPrint(mainIndex.toString());
            //BestSellerScreen().launch(context);
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
            Navigator.pushNamed(context, BestSellerScreen.routeName,
                arguments:
                    ListingItem(listingProduct: listingProduct, title: title));
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
}
