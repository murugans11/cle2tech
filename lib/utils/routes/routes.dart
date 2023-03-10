import 'package:flutter/material.dart'hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopeein/pages/initial_page.dart';

import '../../blocs/make_order/markorder_bloc.dart';
import '../../cubit/cart/cart_list_response_cubit.dart';
import '../../cubit/cart/category_group/category_group_cubit.dart';
import '../../cubit/cart/single_category_group/single_category_items_cubit.dart';
import '../../data/repository/home_repository.dart';
import '../../di/components/service_locator.dart';
import '../../models/categoriesbyname/categorieItems.dart';
import '../../models/feature/feature_productes.dart';
import '../../models/gift/GiftDetailRequest.dart';
import '../../models/otp_verify/OrderOtpVerifyRequest.dart';
import '../../models/register/request_otp.dart';
import '../../models/wishlist/verifywishlist.dart';
import '../../pages/auth_screen/log_in_screen.dart';
import '../../pages/auth_screen/otp_auth_screen.dart';
import '../../pages/auth_screen/sign_up.dart';
import '../../pages/best_seller_screen.dart';
import '../../pages/cart_screen.dart';
import '../../pages/category_screen.dart';
import '../../pages/confirm_order_screen.dart';
import '../../pages/event/event_form_other_screen.dart';
import '../../pages/event/event_form_screen.dart';
import '../../pages/event/event_intro_screen.dart';
import '../../pages/gift_detail_screen.dart';
import '../../pages/gift_screen.dart';
import '../../pages/home_page.dart';
import '../../pages/my_order.dart';
import '../../pages/my_profile_screen.dart';
import '../../pages/my_wallet_screen.dart';
import '../../pages/pin_code_verification_screen.dart';
import '../../pages/product_detail_screen.dart';
import '../../pages/profile_screen.dart';
import '../../pages/search_page.dart';
import '../../pages/shipping_address.dart';
import '../../pages/single_category_by_Item_screen.dart';
import '../../pages/single_category_group_screen.dart';
import '../../pages/splash_screen_one.dart';
import '../../widgets/offer_screen.dart';

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
      case EventIntroScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const EventIntroScreen(),
        );

      case EventFormScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => EventFormScreen(),
        );

        case MyWallet.routeName:
        return MaterialPageRoute(
          builder: (context) => const MyWallet(),
        );

        case EventFormOtherScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => EventFormOtherScreen(),
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
            create: (context) =>
                CategoryGroupCubit(homeRepository: getIt<HomeRepository>()),
            child: const SingleCategoryGroupScreen(),
          ),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case SingleCategoryByItemScreen.routeName:
        dynamicArguments as CategoryItemDisplay;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SingleCategoryCubit>(
            create: (context) =>
                SingleCategoryCubit(homeRepository: getIt<HomeRepository>()),
            child: const SingleCategoryByItemScreen(),
          ),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case ConfirmOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MakeOrderBloc>(
            create: (context) =>
                MakeOrderBloc(homeRepository: getIt<HomeRepository>()),
            child: const ConfirmOrderScreen(),
          ),
        );

      case PinCodeVerificationScreen.routeName:
        dynamicArguments as OrderOtpVerifyRequest;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MakeOrderBloc>(
            create: (context) =>
                MakeOrderBloc(homeRepository: getIt<HomeRepository>()),
            child: const PinCodeVerificationScreen(),
          ),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case ProductDetailScreen.routeName:
        final args = dynamicArguments as ListingProduct;
        return MaterialPageRoute(
          builder: (context) => const ProductDetailScreen(),
          settings: RouteSettings(arguments: args),
        );

      case MyProfileScreen.routeName:
        final args = dynamicArguments as Profile;
        return MaterialPageRoute(
          builder: (context) => const MyProfileScreen(),
          settings: RouteSettings(arguments: args),
        );

      case GiftPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const GiftPage(),
        );

      case LogInScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return const LogInScreen();
          },
        );
      case MyOrderScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return const MyOrderScreen();
          },
        );

      case OtpAuthScreen.routeName:
        final args = dynamicArguments as RequestOtp;
        return MaterialPageRoute(
          builder: (context) => const OtpAuthScreen(),
          settings: RouteSettings(arguments: args),
        );

      case GiftDetailPage.routeName:
        final args = dynamicArguments as GiftDetailRequest;
        return MaterialPageRoute(
          builder: (context) => const GiftDetailPage(),
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
          builder: (context) => BlocProvider<CartListResponseCubit>(
            create: (context) =>
                CartListResponseCubit(homeRepository: getIt<HomeRepository>()),
            child: const CartScreen(),
          ),
          settings: RouteSettings(arguments: dynamicArguments),
        );

      case ShippingAddressPage.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return const ShippingAddressPage();
          },
        );

      case OfferScreen.routeName:
        return MaterialPageRoute(
          builder: (_) {
            return const OfferScreen();
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
