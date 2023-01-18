class PincodeResponse {
  int? status;
  String? message;
  Result? result;

  PincodeResponse({this.status, this.message, this.result});

  PincodeResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

}

class Result {
  String? pincode;
  bool? isDelivery;
  bool? isCOD;
  bool? isExpressDelivery;

  Result({this.pincode, this.isDelivery, this.isCOD, this.isExpressDelivery});

  Result.fromJson(Map<String, dynamic> json) {
    pincode = json['pincode'];
    isDelivery = json['isDelivery'];
    isCOD = json['isCOD'];
    isExpressDelivery = json['isExpressDelivery'];
  }


}
