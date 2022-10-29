import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopeein/data/network/dio_client.dart';
import 'package:shopeein/data/repository/home_repository.dart';
import 'package:shopeein/data/sharedpref/shared_preference_helper.dart';
import 'package:shopeein/di/module/local_module.dart';
import 'package:shopeein/di/module/network_module.dart';


import '../../data/network/apis/home/home_api.dart';
import '../../data/repository/login_repository.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {


  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<SharedPreferences>(() => LocalModule.provideSharedPreference());

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));

  getIt.registerSingleton(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));

  getIt.registerSingleton(DioClient(getIt<Dio>()));


  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(HomeApi(getIt<DioClient>()));


  // repository:----------------------------------------------------------------
  getIt.registerSingleton(HomeRepository(getIt<HomeApi>()));
  getIt.registerSingleton(LoginRepository(getIt<SharedPreferenceHelper>(),getIt<HomeApi>()));


}
