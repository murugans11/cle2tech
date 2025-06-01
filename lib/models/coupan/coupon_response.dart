class CouponResponse {
  int? status;
  String? message;
  List<Coupon>? coupon;

  CouponResponse({this.status, this.message, this.coupon});

  CouponResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['coupon'] != null) {
      coupon = <Coupon>[];
      json['coupon'].forEach((v) {
        coupon!.add(Coupon.fromJson(v));
      });
    }
  }
}

class Coupon {
  String? couponCode;
  String? offerName;
  String? type;
  String? method;
  String? startDate;
  String? endDate;
  int? discount;
  int? maximumDiscount;
  int? minimumAmountCart;
  int? maximumTotalUsage;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? usedCount;
  bool? isDelete;
  String? id;

  Coupon(
      {this.couponCode,
      this.offerName,
      this.type,
      this.method,
      this.startDate,
      this.endDate,
      this.discount,
      this.maximumDiscount,
      this.minimumAmountCart,
      this.maximumTotalUsage,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.usedCount,
      this.isDelete,
      this.id});

  Coupon.fromJson(Map<String, dynamic> json) {
    couponCode = json['couponCode'];
    offerName = json['offerName'];
    type = json['type'];
    method = json['method'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    discount = json['discount'];
    maximumDiscount = json['maximumDiscount'];
    minimumAmountCart = json['minimumAmountCart'];
    maximumTotalUsage = json['maximumTotalUsage'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    usedCount = json['usedCount'];
    isDelete = json['isDelete'];
    id = json['id'];
  }
}
