import 'package:http/http.dart' as http;

String httpErrorHandler(int? statusCode ,String? reasonPhrase) {

  final String errorMessage =
      'Request failed\nStatus Code: $statusCode\nReason: $reasonPhrase';

  return errorMessage;
}
