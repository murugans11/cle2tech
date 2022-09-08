import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopeein/blocs/banner/bannarList_bloc.dart';

import 'blocs/category/categoryList_bloc.dart';
import 'blocs/featureproduct/feature_product_list_bloc.dart';
import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'data/repository/home_repository.dart';
import 'di/components/service_locator.dart';
import 'utils/routes/routes.dart' as Router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setPreferredOrientations();

  await setupLocator();

  return runZonedGuarded(() async {
    runApp((const MyApp()));
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    /*DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,*/
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => getIt<HomeRepository>(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoriesBloc>(
            create: (context) =>
                CategoriesBloc(homeRepository: context.read<HomeRepository>()),
          ),
          BlocProvider<BannerBloc>(
            create: (context) =>
                BannerBloc(homeRepository: context.read<HomeRepository>()),
          ),
          BlocProvider<FeatureProductListBloc>(
            create: (context) => FeatureProductListBloc(
                homeRepository: context.read<HomeRepository>()),
          ),
        ],
        child: AppTheme(
          child: Builder(builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Strings.appName,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: AppTheme.of(context)?.colors.mPrimaryColor,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: AppTheme.of(context)?.colors.mPrimaryColor),
              ),
              onGenerateRoute: Router.Router.generateRoute,
              //home: const HomePage(),
            );
          }),
        ),
      ),
    );
  }
}
