import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:shopeein/pages/single_category_by_Item_screen.dart';
import 'package:shopeein/pages/single_category_group_screen.dart';


import '../blocs/category_groupe/categoryList_bloc.dart';
import '../constants/constants.dart';
import '../models/categoriesbyname/categorieItems.dart';
import '../widgets/category_view.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = "/CategoryScreen";

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    //context.read<CategoriesBloc>().add(const FetchCategoriesItemsEvent());
  }

  List<Color> colors = const [
    Color(0xFFFCF3D7),
    Color(0xFFDCF7E3),
    Color(0xFFFEE4E2),
    Color(0xFFE5EFFF),
    Color(0xFFDAF5F2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const MyGoogleText(
          text: 'Categories',
          fontColor: secondaryColor2,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: BlocBuilder<CategoriesBloc, CategoryState>(
        builder: (context, state) {
          var cound = state.categoryList.categoryGroup?.length ?? 0;
          return CustomScrollView(
            slivers: [
              for (var i = 0; i < cound; i++) buildListView(state, context, i)
            ],
          );
        },
      ),
    );
  }

  Widget buildListView(CategoryState state, BuildContext context, int index) {
    final random = Random();

    List list = state.categoryList.categoryGroup?[index].category;
    List<CategoryItemDisplay> category = [];
    for (var element in list) {
      List e1 = element;
      for (var element1 in e1) {
        category.add(
          CategoryItemDisplay(
            name: element1['name'],
            displayName: element1['displayName'],
            path: element1['path'],
          ),
        );
      }
    }

    return SliverStickyHeader(
      header: Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: CategoryView(
            name: state.categoryList.categoryGroup?[index].title ?? '',
            items: '10',
            color: colors[random.nextInt(colors.length)],
            image: state.categoryList.categoryGroup?[index].image ?? '',
            onTabFunction: () {
              //const SingleCategoryScreen().launch(context);
            },
          ),
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            onTap: () {
              Navigator.pushNamed(context, SingleCategoryByItemScreen.routeName, arguments: category[i]);
            },
            title: Text(category[i].displayName ?? ''),
          ),
          childCount: category.length,
        ),
      ),
    );
  }
}
