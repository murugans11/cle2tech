import 'package:flutter/material.dart';
import 'package:shopeein/pages/initial_page.dart';


import '../../models/categoriesbyname/categorieItems.dart';
import '../../models/feature/feature_productes.dart';
import '../../pages/best_seller_screen.dart';
import '../../pages/cart_screen.dart';
import '../../pages/category_screen.dart';
import '../../pages/home_page.dart';
import '../../pages/product_detail_screen.dart';
import '../../pages/profile_screen.dart';
import '../../pages/search_page.dart';
import '../../pages/single_category_screen.dart';
import '../../pages/splash_screen_one.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final dynamicArguments = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return const SplashScreenOne();
        });
      case InitialPage.routeName:
        return MaterialPageRoute(builder: (_) {
          return const InitialPage();
        });

      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) {
          return const HomePage();
        });

      case CategoryScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );

      case BestSellerScreen.routeName:
        final args = dynamicArguments as ListingItem;
        return MaterialPageRoute(
          builder: (context) => const BestSellerScreen(),
          settings: RouteSettings(arguments: args),
        );

      case SingleCategoryScreen.routeName:
        dynamicArguments as CategoryItemDisplay;
        return MaterialPageRoute(
          builder: (context) => const SingleCategoryScreen(),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case ProductDetailScreen.routeName:
        final args = dynamicArguments as ListingProduct;
        return MaterialPageRoute(
          builder: (context) => const ProductDetailScreen(),
          settings: RouteSettings(arguments: args),
        );

      case CartScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return const CartScreen();
          },
        );

      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (_) {
          return const ProfileScreen();
        });

      case SearchPage.routeName:
        return MaterialPageRoute(builder: (_) {
          return const SearchPage();
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
