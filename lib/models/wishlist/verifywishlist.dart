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

}

class User {
  Profile? profile;
  List<Wishlist>? wishlist;
  List<Addresses>? addresses;

  User({this.profile,this.wishlist,this.addresses,});

  User.fromJson(Map<String, dynamic> json) {

    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;

    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(Wishlist.fromJson(v));
      });
    }

    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) { addresses!.add(Addresses.fromJson(v)); });
    }


  }

}

class Profile {
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? picture;
  String? isVerified;
  String? gender;

  Profile({this.firstName, this.lastName, this.mobileNo, this.picture, this.isVerified, this.gender});

  Profile.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    picture = json['picture'];
    isVerified = json['isVerified'];
    gender = json['gender'];
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


}

class Addresses {
  String? addressId;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? pincode;
  String? locality;
  String? address;
  String? city;
  String? state;
  String? country;
  String? addressType;
  String? sId;

  Addresses({this.addressId, this.firstName, this.lastName, this.mobileNo, this.pincode, this.locality, this.address, this.city, this.state, this.country, this.addressType, this.sId});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    pincode = json['pincode'];
    locality = json['locality'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    addressType = json['addressType'];
    sId = json['_id'];
  }
}
