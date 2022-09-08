import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopeein/blocs/banner/bannerList_event.dart';
import 'package:shopeein/blocs/banner/bannerList_state.dart';
import 'package:shopeein/constants/app_theme.dart';
import 'package:shopeein/models/feature/feature_productes.dart';

import '../blocs/banner/bannarList_bloc.dart';
import '../blocs/category/categoryList_bloc.dart';
import '../blocs/featureproduct/feature_product_list_bloc.dart';
import '../utils/dio/network_call_status_enum.dart';
import '../widgets/app_widgets.dart';
import '../widgets/error_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/HomePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().add(const FetchCategoriesItemsEvent());
    context.read<BannerBloc>().add(const FetchBannerItemsEvent());
    context.read<FeatureProductListBloc>().add(const FetchFeatureProductItemsEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10),
          _createCategories(),
          const SizedBox(height: 10),
          _createBannerItems(),
          const SizedBox(height: 10),
          _showFeatureList(),
        ],
      ),
    );
  }

  /*Crete Categories list*/
  Widget _createCategories() {
    return BlocConsumer<CategoriesBloc, CategoryState>(
      listener: (context, state) {
        if (state.status == NetworkCallStatusEnum.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
      builder: (context, state) {
        return Card(
          shadowColor: Colors.grey,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 107,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.categoryList.categoryGroup!.length,
              itemBuilder: (BuildContext context, int index) {
                return _roundCard(
                    () => print('index $index'),
                    state.categoryList.categoryGroup![index].title,
                    state.categoryList.categoryGroup![index].image);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _roundCard(
    Function findSelectedCategoriesItem,
    String? categoriesItemName,
    String imageUrl,
  ) {
    return InkWell(
      onTap: () {
        findSelectedCategoriesItem();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
        child: Column(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
              ),
            ),
            Text(
              categoriesItemName ?? '',
              style: AppTheme.of(context)?.textStyles.kBordStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget _createBannerItems() {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {
        if (state.status == NetworkCallStatusEnum.loaded) {
          return Card(
            shadowColor: Colors.grey,
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: state.bannerList.categoryGroup?.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {
                        //  print('index of banner ${imgList.indexOf(i.resourcePath)}');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.amber),
                        child: Image.network(i.resourcePath,
                            fit: BoxFit.cover, width: 1000.0),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        }
        return Container();
      },
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
        return Card(
          elevation: 8,
          shadowColor: AppTheme.of(context)?.colors.screenBackGroundColor,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              headText(state.featureProductList.featureProduct?[mainIndex].title),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.featureProductList
                            .featureProduct?[mainIndex].listing?.length ??
                        0,
                    itemBuilder: (BuildContext context, int subIndex) {
                      return Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        margin: EdgeInsets.zero,
                        //margin: const EdgeInsets.only(left:0.0,right: 10.0),
                        clipBehavior: Clip.antiAlias,
                        child: productCard(() {}, state, mainIndex, subIndex),
                      );
                    },
                  ))
            ],
          ),
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
