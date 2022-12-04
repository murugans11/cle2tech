import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopeein/pages/initial_page.dart';

import '../../cubit/category_group_cubit.dart';
import '../../cubit/single_category_items_cubit.dart';
import '../../data/repository/home_repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/categoriesbyname/categorieItems.dart';
import '../../models/feature/feature_productes.dart';
import '../../models/register/request_otp.dart';
import '../../pages/auth_screen/log_in_screen.dart';
import '../../pages/auth_screen/otp_auth_screen.dart';
import '../../pages/auth_screen/sign_up.dart';
import '../../pages/best_seller_screen.dart';
import '../../pages/cart_screen.dart';
import '../../pages/category_screen.dart';
import '../../pages/home_page.dart';
import '../../pages/product_detail_screen.dart';
import '../../pages/profile_screen.dart';
import '../../pages/search_page.dart';
import '../../pages/single_category_by_Item_screen.dart';
import '../../pages/single_category_group_screen.dart';
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

      case SingleCategoryGroupScreen.routeName:
        dynamicArguments as CategoryItemDisplay;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<CategoryGroupCubit>(
            create: (context) => CategoryGroupCubit(homeRepository: getIt<HomeRepository>()),
            child: const SingleCategoryGroupScreen(),
          ),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case SingleCategoryByItemScreen.routeName:
        dynamicArguments as CategoryItemDisplay;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SingleCategoryCubit>(
            create: (context) => SingleCategoryCubit(homeRepository: getIt<HomeRepository>()),
            child: const SingleCategoryByItemScreen(),
          ),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case ProductDetailScreen.routeName:
        final args = dynamicArguments as ListingProduct;
        return MaterialPageRoute(
          builder: (context) => const ProductDetailScreen(),
          settings: RouteSettings(arguments: args),
        );

      case LogInScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return const LogInScreen();
          },
        );

      case OtpAuthScreen.routeName:
        final args = dynamicArguments as RequestOtp;
        return MaterialPageRoute(
          builder: (context) => const OtpAuthScreen(),
          settings: RouteSettings(arguments: args),
        );

      case SignUp.routeName:
        final args = dynamicArguments as RequestOtp;
        return MaterialPageRoute(
          builder: (context) => const SignUp(),
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
