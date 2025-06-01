class OrderInitResponce {
  int? status;
  String? message;
  OrderData? orderData;

  OrderInitResponce({this.status, this.message, this.orderData});

  OrderInitResponce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderData = json['orderData'] != null
        ? OrderData.fromJson(json['orderData'])
        : null;
  }

}

class OrderData {
  String? orderId;

  OrderData(
      {this.orderId,
      });

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];

  }


}

