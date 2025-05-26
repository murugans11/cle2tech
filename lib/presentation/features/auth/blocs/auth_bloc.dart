import 'package:bloc/bloc.dart';

// Basic States
abstract class AuthState {}
class AuthInitial extends AuthState {}
class Authenticated extends AuthState {
  // final User user; // User would come from domain layer
  // Authenticated(this.user);
}
class Unauthenticated extends AuthState {}

// Basic Events
abstract class AuthEvent {}
class AppStarted extends AuthEvent {}
class LoggedOut extends AuthEvent {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final GetCurrentUser getCurrentUser; // From domain use cases
  // final LogoutUser logoutUser; // From domain use cases

  AuthBloc(/*this.getCurrentUser, this.logoutUser*/) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      // In future, would check current user status
      // For now, just emit unauthenticated
      emit(Unauthenticated());
    });
    on<LoggedOut>((event, emit) async {
      // In future, call logoutUser use case
      emit(Unauthenticated());
    });
  }
}
