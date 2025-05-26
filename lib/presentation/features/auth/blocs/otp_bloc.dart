import 'package:bloc/bloc.dart';

// Basic States
abstract class OtpState {}
class OtpInitial extends OtpState {}
class OtpLoading extends OtpState {}
class OtpVerificationSuccess extends OtpState {} // User logged in
class OtpFailure extends OtpState {
  // final String error;
  // OtpFailure(this.error);
}
class OtpSentSuccess extends OtpState { // OTP code sent, awaiting verification
    // final String verificationId;
    // OtpSentSuccess(this.verificationId);
}


// Basic Events
abstract class OtpEvent {}
class OtpRequestSubmitted extends OtpEvent {
    // final String phoneNumber;
    // OtpRequestSubmitted(this.phoneNumber);
}
class OtpVerifySubmitted extends OtpEvent {
    // final String verificationId;
    // final String otpCode;
    // OtpVerifySubmitted(this.verificationId, this.otpCode);
}


class OtpBloc extends Bloc<OtpEvent, OtpState> {
  // final RequestOtp requestOtpUseCase;
  // final VerifyOtp verifyOtpUseCase;
  // final AuthBloc authBloc;

  OtpBloc(/*this.requestOtpUseCase, this.verifyOtpUseCase, this.authBloc*/) : super(OtpInitial()) {
    on<OtpRequestSubmitted>((event, emit) {
      emit(OtpLoading());
      // In future, call requestOtpUseCase
      // emit(OtpSentSuccess("dummy_verification_id")); // Simulate success
    });
    on<OtpVerifySubmitted>((event, emit) {
      emit(OtpLoading());
      // In future, call verifyOtpUseCase
      // emit(OtpVerificationSuccess()); // Simulate success
    });
  }
}
