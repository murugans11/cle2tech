import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shopeein/pages/categories_page.dart';
import 'package:shopeein/pages/delivery_page.dart';
import 'package:shopeein/pages/fan_club_page.dart';
import 'package:shopeein/pages/home_page.dart';
import 'package:shopeein/pages/search_page.dart';
import 'package:shopeein/pages/wishlist_page.dart';

import '../constants/app_theme.dart';

class InitialPage extends StatefulWidget {
  static const String routeName = "/InitialPage";

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    HomePage(),
    FanclubPage(),
    CategoriesPage(),
    WishListPage(),
    DeliveryPage(),
  ];

  _onButtonBarSwitch(int newIndex) {
    setState(() {
      _selectedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTheme.of(context)?.values.appName ?? ''),
        backgroundColor: AppTheme.of(context)?.colors.mPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: tabs,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: const Text("Murugan@gmail.com"),
              accountName: const Text("Murugan"),
              currentAccountPicture: ClipRRect(
                child: Image.asset(
                  AppTheme.of(context)?.assets.launching_Icon_App ?? '',
                  fit: BoxFit.fill,
                  width: 30,
                  height: 30,
                ),
              ),
              otherAccountsPictures: <Widget>[
                ClipRRect(
                  child: Text(
                    'Edit',
                    style: AppTheme.of(context)
                        ?.textStyles
                        .kSubtitleStyle
                        .copyWith(color: Colors.blue[900]),
                  ),
                ),
              ],
              decoration: BoxDecoration(
                  color: AppTheme.of(context)?.colors.mPrimaryColor),
            ),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
                /* Navigator.pop(context);
                Navigator.pushNamed(context, SearchPage.routeName);*/
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.shopping_basket_outlined,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Orders',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
                /* Navigator.pop(context);
                Navigator.pushNamed(context, SearchPage.routeName);*/
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.notifications_active,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                AppTheme.of(context)?.values.notifications ?? "",
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.replay_circle_filled_sharp,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Return and Refund',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.card_giftcard_outlined,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'My Reward',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.group_add_outlined,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Referals',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.wallet,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Wallets',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Track Order',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.maps_home_work_outlined,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Address',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.edit_note,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Terms and Conditions',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.person_pin_circle,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'Help Center',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(vertical: -4),
              onTap: () {
                finish(context);
                SearchPage().launch(context);
              },
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.help_outline_sharp,
                size: 20,
                color: Colors.black54,
              ).paddingOnly(left: 8),
              title: Text(
                'FAQ',
                style: AppTheme.of(context)?.textStyles.kSubtitleStyle,
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ).paddingOnly(right: 8),
            ),
            const Divider(thickness: 1),
            ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
              title: RichText(
                // Controls visual overflow
                overflow: TextOverflow.ellipsis,

                // Controls how the text should be aligned horizontally
                textAlign: TextAlign.center,

                // Control the text direction
                textDirection: TextDirection.rtl,

                // Whether the text should break at soft line breaks
                softWrap: true,

                // Maximum number of lines for the text to span
                maxLines: 1,

                // The number of font pixels for each logical pixel
                textScaleFactor: 1,
                text: TextSpan(
                  text: 'Power By ',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppTheme.of(context)?.colors.appSubTitleTextColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'SHOPEEIN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.of(context)?.colors.mPrimaryColor),
                    ),
                  ],
                ),
              ),
              /*title: Text(
                'Power By Shoppein',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  color: AppTheme.of(context)?.colors.mPrimaryColor,
                ),
              ),*/
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage(AppTheme.of(context)?.assets.shopeeinBag ?? '')),
            label: AppTheme.of(context)?.values.home,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage(AppTheme.of(context)?.assets.fanClubs ?? '')),
            label: AppTheme.of(context)?.values.fanClub,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage(AppTheme.of(context)?.assets.categories ?? '')),
            label: AppTheme.of(context)?.values.categories,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage(AppTheme.of(context)?.assets.wishlist ?? '')),
            label: AppTheme.of(context)?.values.whishlist,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
                AssetImage(AppTheme.of(context)?.assets.fourHrDelivery ?? '')),
            label: AppTheme.of(context)?.values.hrDelivery,
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.of(context)?.colors.mPrimaryColor,
        onTap: (index) {
          if (_selectedIndex != index) _onButtonBarSwitch(index);
        },
      ),
    );
  }
}
