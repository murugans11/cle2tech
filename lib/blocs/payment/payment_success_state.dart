import 'package:equatable/equatable.dart';

// Define states
abstract class PaymentSuccessState extends Equatable {
  const PaymentSuccessState();

  @override
  List<Object> get props => [];
}

class PaymentSuccessInitial extends PaymentSuccessState {
  const PaymentSuccessInitial();

  factory PaymentSuccessInitial.initial() {
    return const PaymentSuccessInitial();
  }
}

class PaymentSuccessLoading extends PaymentSuccessState {
  const PaymentSuccessLoading();

  @override
  List<Object> get props => [];
}

class PaymentSuccessLoaded extends PaymentSuccessState {
  final String response;

  const PaymentSuccessLoaded({
    required this.response,
  });

  @override
  List<Object> get props => [response];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return 'PaymentSuccessState{ response: $response, }';
  }

  PaymentSuccessState copyWith({
    String? response1,
  }) {
    return PaymentSuccessLoaded(
      response: response1 ?? response,
    );
  }
}

class PaymentSuccessError extends PaymentSuccessState {
  final String message;

  const PaymentSuccessError({required this.message});

  @override
  List<Object> get props => [message];
}
