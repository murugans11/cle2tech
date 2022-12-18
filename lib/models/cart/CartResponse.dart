import '../feature/feature_productes.dart';

class CartResponse {
  int? status;
  String? message;
  List<CartDetails>? cartDetails;
  PriceDetails? priceDetails;
  List<ListingProduct>? listingProduct;

  CartResponse({
    this.status,
    this.message,
    this.cartDetails,
    this.priceDetails,
    this.listingProduct,
  });

  CartResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['cartDetails'] != null) {
      cartDetails = <CartDetails>[];
      json['cartDetails'].forEach((v) {
        cartDetails!.add(CartDetails.fromJson(v));
      });
    }

    priceDetails = json['priceDetails'] != null
        ? PriceDetails.fromJson(json['priceDetails'])
        : null;

    if (json['listingProduct'] != null) {
      listingProduct = <ListingProduct>[];
      json['listingProduct'].forEach((v) {
        listingProduct!.add(ListingProduct.fromJson(v));
      });
    }
  }
}

class CartDetails {
  String? sku;
  dynamic qty;
  String? productTitle;
  dynamic sellingPrice;
  dynamic retailPrice;
  dynamic productId;
  ResourcePath? resourcePath;
  List<OptionalAttributes>? optionalAttributes;
  bool? isCashOnDelivery;
  String? slug;
  dynamic mrp;

  CartDetails(
      {this.sku,
      this.qty,
      this.productTitle,
      this.sellingPrice,
      this.retailPrice,
      this.productId,
      this.resourcePath,
      this.optionalAttributes,
      this.isCashOnDelivery,
      this.slug,
      this.mrp});

  CartDetails.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    qty = json['qty'];
    productTitle = json['productTitle'];
    sellingPrice = json['sellingPrice'];
    retailPrice = json['retailPrice'];
    productId = json['productId'];
    resourcePath = json['resourcePath'] != null
        ? ResourcePath.fromJson(json['resourcePath'])
        : null;
    if (json['optionalAttributes'] != null) {
      optionalAttributes = <OptionalAttributes>[];
      json['optionalAttributes'].forEach((v) {
        optionalAttributes!.add(OptionalAttributes.fromJson(v));
      });
    }
    isCashOnDelivery = json['isCashOnDelivery'];
    slug = json['slug'];
    mrp = json['mrp'];
  }
}

class ResourcePath {
  String? type;
  String? resourcePath;
  String? sId;

  ResourcePath({this.type, this.resourcePath, this.sId});

  ResourcePath.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    resourcePath = json['resourcePath'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['resourcePath'] = this.resourcePath;
    data['_id'] = this.sId;
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
      {this.attributeType,
      this.displayName,
      this.inputType,
      this.name,
      this.attributeStyle,
      this.attributeOptionValue,
      this.sId});

  OptionalAttributes.fromJson(Map<String, dynamic> json) {
    attributeType = json['attributeType'];
    displayName = json['displayName'];
    inputType = json['inputType'];
    name = json['name'];
    attributeStyle = json['attributeStyle'];
    if (json['attributeOptionValue'] != null) {
      attributeOptionValue = <AttributeOptionValue>[];
      json['attributeOptionValue'].forEach((v) {
        attributeOptionValue!.add(new AttributeOptionValue.fromJson(v));
      });
    }
    sId = json['_id'];
  }
}

class AttributeOptionValue {
  String? displayName;
  String? value;
  String? sId;

  AttributeOptionValue({this.displayName, this.value, this.sId});

  AttributeOptionValue.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['value'] = value;
    data['_id'] = this.sId;
    return data;
  }
}

class PriceDetails {
  int? count;
  int? price;
  int? sellingPrice;
  int? discount;
  int? couponDiscount;
  int? deliveryCharges;
  int? totalAmount;

  PriceDetails(
      {this.count,
      this.price,
      this.sellingPrice,
      this.discount,
      this.couponDiscount,
      this.deliveryCharges,
      this.totalAmount});

  PriceDetails.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    price = json['price'];
    sellingPrice = json['sellingPrice'];
    discount = json['discount'];
    couponDiscount = json['couponDiscount'];
    deliveryCharges = json['deliveryCharges'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['price'] = this.price;
    data['sellingPrice'] = this.sellingPrice;
    data['discount'] = this.discount;
    data['couponDiscount'] = this.couponDiscount;
    data['deliveryCharges'] = this.deliveryCharges;
    data['totalAmount'] = this.totalAmount;
    return data;
  }
}

class AttributeGroup {
  String? groupName;
  List<Attributes>? attributes;
  String? sId;

  AttributeGroup({this.groupName, this.attributes, this.sId});

  AttributeGroup.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    sId = json['_id'];
  }
}

class Attributes {
  String? id;
  String? displayName;
  String? value;
  String? sId;

  Attributes({this.id, this.displayName, this.value, this.sId});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    value = json['value'];
    sId = json['_id'];
  }
}
