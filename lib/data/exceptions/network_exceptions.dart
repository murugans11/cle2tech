
import 'package:equatable/equatable.dart';

class CustomException  extends Equatable implements Exception  {
  final String message;
  final int? statusCode;

  const CustomException({required this.message, this.statusCode});

  @override
  String toString() {
    return 'CustomException: statusCode: $statusCode, message: $message';
  }

  @override
  List<Object?> get props => [message,statusCode];

  @override
  bool get stringify => true;
}

