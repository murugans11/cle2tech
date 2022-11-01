class VerifyWishlist {
  bool? success;
  String? message;
  User? user;

  VerifyWishlist({this.success, this.message, this.user});

  VerifyWishlist.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  List<Wishlist>? wishlist;

  User({this.wishlist});

  User.fromJson(Map<String, dynamic> json) {
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (wishlist != null) {
      data['wishlist'] = wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist {
  String? sku;
  String? listingId;
  String? sId;

  Wishlist({this.sku, this.listingId, this.sId});

  Wishlist.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    listingId = json['listingId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['listingId'] = listingId;
    data['_id'] = sId;
    return data;
  }
}
