import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';
import '../../domain/entities/user.dart'; // User entity

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginNotifier(this._loginUseCase) : super(const LoginInitial());

  Future<void> login(String email, String password) async {
    state = const LoginLoading();
    try {
      final user = await _loginUseCase.call(email, password);
      state = LoginSuccess(user);
    } catch (e) {
      state = LoginError(e.toString());
    }
  }
}
