class MyOrderResponse {
  int? status;
  String? message;
  List<Listing>? listing;
  List<OrderItem>? orderItem;
  List<Order>? order;

  MyOrderResponse(
      {status, message, listing, orderItem, order});

  MyOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['listing'] != null) {
      listing = <Listing>[];
      json['listing'].forEach((v) {
        listing!.add(Listing.fromJson(v));
      });
    }
    if (json['orderItem'] != null) {
      orderItem = <OrderItem>[];
      json['orderItem'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    }
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (listing != null) {
      data['listing'] = listing!.map((v) => v.toJson()).toList();
    }
    if (orderItem != null) {
      data['orderItem'] = orderItem!.map((v) => v.toJson()).toList();
    }
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Listing {
  String? sku;
  int? qty;
  String? productTitle;
  String? sellingPrice;
  int? retailPrice;
  String? productId;
  ResourcePath? resourcePath;
  List<OptionalAttributes>? optionalAttributes;
  bool? isCashOnDelivery;
  String? slug;
  String? mrp;

  Listing(
      {sku,
        qty,
        productTitle,
        sellingPrice,
        retailPrice,
        productId,
        resourcePath,
        optionalAttributes,
        isCashOnDelivery,
        slug,
        mrp});

  Listing.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    qty = json['qty'];
    productTitle = json['productTitle'];
    sellingPrice = json['sellingPrice'];
    retailPrice = json['retailPrice'];
    productId = json['productId'];
    resourcePath = json['resourcePath'] != null
        ?  ResourcePath.fromJson(json['resourcePath'])
        : null;
    if (json['optionalAttributes'] != null) {
      optionalAttributes = <OptionalAttributes>[];
      json['optionalAttributes'].forEach((v) {
        optionalAttributes!.add( OptionalAttributes.fromJson(v));
      });
    }
    isCashOnDelivery = json['isCashOnDelivery'];
    slug = json['slug'];
    mrp = json['mrp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['sku'] = sku;
    data['qty'] = qty;
    data['productTitle'] = productTitle;
    data['sellingPrice'] = sellingPrice;
    data['retailPrice'] = retailPrice;
    data['productId'] = productId;
    if (resourcePath != null) {
      data['resourcePath'] = resourcePath!.toJson();
    }
    if (optionalAttributes != null) {
      data['optionalAttributes'] =
          optionalAttributes!.map((v) => v.toJson()).toList();
    }
    data['isCashOnDelivery'] = isCashOnDelivery;
    data['slug'] = slug;
    data['mrp'] = mrp;
    return data;
  }
}

class ResourcePath {
  String? type;
  String? resourcePath;
  String? sId;

  ResourcePath({type, resourcePath, sId});

  ResourcePath.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    resourcePath = json['resourcePath'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['type'] = type;
    data['resourcePath'] = resourcePath;
    data['_id'] = sId;
    return data;
  }
}

class OptionalAttributes {
  String? attributeType;
  String? displayName;
  String? inputType;
  String? name;
  String? attributeStyle;
  List<AttributeOptionValue>? attributeOptionValue;
  String? sId;

  OptionalAttributes(
      {attributeType,
        displayName,
        inputType,
        name,
        attributeStyle,
        attributeOptionValue,
        sId});

  OptionalAttributes.fromJson(Map<String, dynamic> json) {
    attributeType = json['attributeType'];
    displayName = json['displayName'];
    inputType = json['inputType'];
    name = json['name'];
    attributeStyle = json['attributeStyle'];
    if (json['attributeOptionValue'] != null) {
      attributeOptionValue = <AttributeOptionValue>[];
      json['attributeOptionValue'].forEach((v) {
        attributeOptionValue!.add( AttributeOptionValue.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['attributeType'] = attributeType;
    data['displayName'] = displayName;
    data['inputType'] = inputType;
    data['name'] = name;
    data['attributeStyle'] = attributeStyle;
    if (attributeOptionValue != null) {
      data['attributeOptionValue'] =
          attributeOptionValue!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    return data;
  }
}

class AttributeOptionValue {
  String? displayName;
  String? value;
  String? sId;

  AttributeOptionValue({displayName, value, sId});

  AttributeOptionValue.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['displayName'] = displayName;
    data['value'] = value;
    data['_id'] = sId;
    return data;
  }
}

class OrderItem {
  String? orderId;
  String? productId;
  String? sellerId;
  String? productTitle;
  String? price;
  String? sku;
  String? qty;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? id;

  OrderItem(
      {orderId,
        productId,
        sellerId,
        productTitle,
        price,
        sku,
        qty,
        status,
        createdAt,
        updatedAt,
        id});

  OrderItem.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    productId = json['productId'];
    sellerId = json['sellerId'];
    productTitle = json['productTitle'];
    price = json['price'];
    sku = json['sku'];
    qty = json['qty'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['orderId'] = orderId;
    data['productId'] = productId;
    data['sellerId'] = sellerId;
    data['productTitle'] = productTitle;
    data['price'] = price;
    data['sku'] = sku;
    data['qty'] = qty;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}

class Order {
  ShippingAddress? shippingAddress;
  ShippingAddress? deliveryAddress;
  Coupon? coupon;
  String? orderId;
  String? customerId;
  int? amount;
  String? shipping;
  String? tax;
  String? emailId;
  String? date;
  bool? shipped;
  String? paymentType;
  String? isPayment;
  String? paymentId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? id;

  Order(
      {shippingAddress,
        deliveryAddress,
        coupon,
        orderId,
        customerId,
        amount,
        shipping,
        tax,
        emailId,
        date,
        shipped,
        paymentType,
        isPayment,
        paymentId,
        status,
        createdAt,
        updatedAt,
        id});

  Order.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ?  ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    deliveryAddress = json['deliveryAddress'] != null
        ?  ShippingAddress.fromJson(json['deliveryAddress'])
        : null;
    coupon =
    json['coupon'] != null ?  Coupon.fromJson(json['coupon']) : null;
    orderId = json['orderId'];
    customerId = json['customerId'];
    amount = json['amount'];
    shipping = json['shipping'];
    tax = json['tax'];
    emailId = json['emailId'];
    date = json['date'];
    shipped = json['shipped'];
    paymentType = json['paymentType'];
    isPayment = json['isPayment'];
    paymentId = json['paymentId'];
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
    if (coupon != null) {
      data['coupon'] = coupon!.toJson();
    }
    data['orderId'] = orderId;
    data['customerId'] = customerId;
    data['amount'] = amount;
    data['shipping'] = shipping;
    data['tax'] = tax;
    data['emailId'] = emailId;
    data['date'] = date;
    data['shipped'] = shipped;
    data['paymentType'] = paymentType;
    data['isPayment'] = isPayment;
    data['paymentId'] = paymentId;
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

class Coupon {
  bool? isUsed;
  String? couponId;
  int? discountValue;

  Coupon({isUsed, couponId, discountValue});

  Coupon.fromJson(Map<String, dynamic> json) {
    isUsed = json['isUsed'];
    couponId = json['couponId'];
    discountValue = json['discountValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['isUsed'] = isUsed;
    data['couponId'] = couponId;
    data['discountValue'] = discountValue;
    return data;
  }
}
