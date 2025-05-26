import 'package:bloc/bloc.dart';

// Basic States
abstract class SignUpState {}
class SignUpInitial extends SignUpState {}
class SignUpLoading extends SignUpState {}
class SignUpSuccess extends SignUpState {}
class SignUpFailure extends SignUpState {
  // final String error;
  // SignUpFailure(this.error);
}

// Basic Events
abstract class SignUpEvent {}
class SignUpButtonPressed extends SignUpEvent {
  // final String name;
  // final String email;
  // final String password;
  // SignUpButtonPressed({required this.name, required this.email, required this.password});
}

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // final SignUpUser signUpUserUseCase; // From domain use cases
  // final AuthBloc authBloc;

  SignUpBloc(/*this.signUpUserUseCase, this.authBloc*/) : super(SignUpInitial()) {
    on<SignUpButtonPressed>((event, emit) {
      emit(SignUpLoading());
      // In future, call signUpUserUseCase
      // emit(SignUpFailure("SignUp failed: Not implemented"));
    });
  }
}
