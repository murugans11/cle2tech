import 'package:flutter/material.dart';
import 'package:shopeein/pages/categories_page.dart';
import 'package:shopeein/pages/delivery_page.dart';
import 'package:shopeein/pages/fan_club_page.dart';
import 'package:shopeein/pages/initial_page.dart';

import '../../pages/home_page.dart';
import '../../pages/search_page.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {

    final dynamicArguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return InitialPage();
        });

      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) {
          return const HomePage();
        });

      case FanclubPage.routeName:
        return MaterialPageRoute(builder: (_) {
          return FanclubPage();
        });

      case CategoriesPage.routeName:
        return MaterialPageRoute(builder: (_) {
          return CategoriesPage();
        });

      case DeliveryPage.routeName:
        return MaterialPageRoute(builder: (_) {
          return DeliveryPage();
        });

        case SearchPage.routeName:
        return MaterialPageRoute(builder: (_) {
          return SearchPage();
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          );
        });
    }
  }
}
