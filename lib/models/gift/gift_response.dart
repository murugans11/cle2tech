class GiftResponse {
  int? status;
  String? message;
  List<OrderGift>? orderGift;
  List<Gift>? gift;

  GiftResponse({status, message, orderGift, gift});

  GiftResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['orderGift'] != null) {
      orderGift = <OrderGift>[];
      json['orderGift'].forEach((v) {
        orderGift!.add( OrderGift.fromJson(v));
      });
    }
    if (json['gift'] != null) {
      gift = <Gift>[];
      json['gift'].forEach((v) {
        gift!.add( Gift.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (orderGift != null) {
      data['orderGift'] = orderGift!.map((v) => v.toJson()).toList();
    }
    if (gift != null) {
      data['gift'] = gift!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderGift {
  ShippingAddress? shippingAddress;
  ShippingAddress? deliveryAddress;
  String? giftId;
  String? orderId;
  String? customerId;
  String? date;
  bool? isOpen;
  bool? isClaim;
  String? claimType;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? id;

  OrderGift(
      {shippingAddress,
        deliveryAddress,
        giftId,
        orderId,
        customerId,
        date,
        isOpen,
        isClaim,
        claimType,
        status,
        createdAt,
        updatedAt,
        id});

  OrderGift.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ?  ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    deliveryAddress = json['deliveryAddress'] != null
        ?  ShippingAddress.fromJson(json['deliveryAddress'])
        : null;
    giftId = json['giftId'];
    orderId = json['orderId'];
    customerId = json['customerId'];
    date = json['date'];
    isOpen = json['isOpen'];
    isClaim = json['isClaim'];
    claimType = json['claimType'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    if (deliveryAddress != null) {
      data['deliveryAddress'] = deliveryAddress!.toJson();
    }
    data['giftId'] = giftId;
    data['orderId'] = orderId;
    data['customerId'] = customerId;
    data['date'] = date;
    data['isOpen'] = isOpen;
    data['isClaim'] = isClaim;
    data['claimType'] = claimType;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}

class ShippingAddress {
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? pincode;
  String? locality;
  String? address;
  String? city;
  String? state;
  String? country;

  ShippingAddress(
      {firstName,
        lastName,
        mobileNo,
        pincode,
        locality,
        address,
        city,
        state,
        country});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNo = json['mobileNo'];
    pincode = json['pincode'];
    locality = json['locality'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobileNo'] = mobileNo;
    data['pincode'] = pincode;
    data['locality'] = locality;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    return data;
  }
}

class Gift {
  String? giftCode;
  String? giftName;
  int? minAmount;
  int? maxAmount;
  String? startDate;
  String? endDate;
  String? productName;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? resourcePath;
  List<ProductId>? productId;
  bool? isDelete;
  String? id;

  Gift(
      {giftCode,
        giftName,
        minAmount,
        maxAmount,
        startDate,
        endDate,
        productName,
        status,
        createdAt,
        updatedAt,
        resourcePath,
        productId,
        isDelete,
        id});

  Gift.fromJson(Map<String, dynamic> json) {
    giftCode = json['giftCode'];
    giftName = json['giftName'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    productName = json['productName'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    resourcePath = json['resourcePath'];
    if (json['productId'] != null) {
      productId = <ProductId>[];
      json['productId'].forEach((v) {
        productId!.add( ProductId.fromJson(v));
      });
    }
    isDelete = json['isDelete'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['giftCode'] = giftCode;
    data['giftName'] = giftName;
    data['minAmount'] = minAmount;
    data['maxAmount'] = maxAmount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['productName'] = productName;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['resourcePath'] = resourcePath;
    if (productId != null) {
      data['productId'] = productId!.map((v) => v.toJson()).toList();
    }
    data['isDelete'] = isDelete;
    data['id'] = id;
    return data;
  }
}

class ProductId {
  String? id;
  String? name;

  ProductId({id, name});

  ProductId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
