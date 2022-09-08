import 'dart:async';

import '../sharedpref/shared_preference_helper.dart';

class LoginRepository {

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  LoginRepository(
    this._sharedPrefsHelper,
  );

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await Future.delayed(Duration(seconds: 2), () => true);
  }

  Future<void> saveIsLoggedIn(bool value) => _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

}
