import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';


import '../constants/app_theme.dart';
import '../constants/constants.dart';


class InitialPage extends StatefulWidget {
  static const String routeName = "/InitialPage";

  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  int _selectedIndex = 0;

  _onButtonBarSwitch(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: bottomNavigationBarActions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.home),
            label: AppTheme.of(context)?.values.home,
          ),
          /* BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage(AppTheme.of(context)?.assets.fanClubs ?? '')),
            label: AppTheme.of(context)?.values.fanClub,
          ),*/

          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.bag),
            label: AppTheme.of(context)?.values.cart,
          ),

          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.category),
            label: AppTheme.of(context)?.values.categories,
          ),

          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.heart),
            label: AppTheme.of(context)?.values.whishlist,
          ),

          BottomNavigationBarItem(
            icon: const Icon(IconlyLight.profile),
            label: AppTheme.of(context)?.values.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: textColors,
        unselectedLabelStyle: const TextStyle(color: textColors),
        onTap: (index) {
          if (_selectedIndex != index) _onButtonBarSwitch(index);
        },
      ),
    );
  }
}
