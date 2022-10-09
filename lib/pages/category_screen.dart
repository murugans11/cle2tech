import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/single_category_screen.dart';


import '../constants/constants.dart';
import '../widgets/category_view.dart';

class CategoryScreen extends StatefulWidget {

  static const String routeName = "/CategoryScreen";

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {


  List<Map<String, dynamic>> categoryList = [
    {
      "image": 'images/category_image1.png',
      "title": 'Women',
      "count": '37 items',
    },
    {
      "image": 'images/kids.png',
      "title": 'Kid\'s',
      "count": '27 items',
    },
    {
      "image": 'images/men.png',
      "title": 'Men',
      "count": '49 items',
    },
    {
      "image": 'images/sports.png',
      "title": 'Sport\'s',
      "count": '12 items',
    },
    {
      "image": 'images/shoes.png',
      "title": 'Shoes',
      "count": '32 items',
    },
  ];


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

        title: const MyGoogleText(
          text: 'Categories',
          fontColor: secondaryColor2,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: Container(
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
                    ListView.builder(
                      shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryList.length,
                        itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: CategoryView(
                          name: categoryList[index]['title'],
                          items: categoryList[index]['count'],
                          color: colors[index],
                          image: categoryList[index]['image'],
                          onTabFunction: () {
                            const SingleCategoryScreen().launch(context);
                          },
                        ),
                      );
                    })
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
