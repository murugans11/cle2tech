class RequestOtpResponse {

  RequestOtpResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  late final int status;
  late final String message;
  late final Data data;


  RequestOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.requestId,
    required this.phone,
  });

  late final String requestId;
  late final String phone;

  Data.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    phone = json['mobileNo'];
  }

}
