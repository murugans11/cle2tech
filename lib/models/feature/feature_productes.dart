class Attributes {
  dynamic id;
  dynamic displayName;
  dynamic value;
  dynamic sId;

  Attributes({this.id, this.displayName, this.value, this.sId});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    value = json['value'];
    sId = json['_id'];
  }
}

class AttributeGroup {
  dynamic groupName;
  List<Attributes>? attributes;
  dynamic sId;

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

class ShippingDetails {
  dynamic shippingDays;
  dynamic height;
  dynamic width;
  dynamic length;
  dynamic weight;

  ShippingDetails(
      {this.shippingDays, this.height, this.width, this.length, this.weight});

  ShippingDetails.fromJson(Map<String, dynamic> json) {
    shippingDays = json['shippingDays'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
    weight = json['weight'];
  }
}

class SellerDetails {
  dynamic sellerId;
  dynamic sellerName;

  SellerDetails({this.sellerId, this.sellerName});

  SellerDetails.fromJson(Map<String, dynamic> json) {
    sellerId = json['sellerId'];
    sellerName = json['sellerName'];
  }
}

class AttributeOptionValue {
  dynamic displayName;
  dynamic value;
  dynamic sId;

  AttributeOptionValue({this.displayName, this.value, this.sId});

  AttributeOptionValue.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    value = json['value'];
    sId = json['_id'];
  }
}

class OptionalAttributes {
  dynamic attributeType;
  dynamic displayName;
  dynamic inputType;
  dynamic name;
  List<AttributeOptionValue>? attributeOptionValue;
  dynamic sId;
  dynamic attributeStyle;

  OptionalAttributes(
      {this.attributeType,
      this.displayName,
      this.inputType,
      this.name,
      this.attributeOptionValue,
      this.sId,
      this.attributeStyle});

  OptionalAttributes.fromJson(Map<String, dynamic> json) {
    attributeType = json['attributeType'];
    displayName = json['displayName'];
    inputType = json['inputType'];
    name = json['name'];
    if (json['attributeOptionValue'] != null) {
      attributeOptionValue = <AttributeOptionValue>[];
      json['attributeOptionValue'].forEach((v) {
        attributeOptionValue!.add(AttributeOptionValue.fromJson(v));
      });
    }
    sId = json['_id'];
    attributeStyle = json['attributeStyle'];
  }
}

class Media {
  dynamic type;
  dynamic resourcePath;
  dynamic sId;

  Media({this.type, this.resourcePath, this.sId});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    resourcePath = json['resourcePath'];
    sId = json['_id'];
  }
}

class Variant {
  dynamic sku;
  dynamic sellerSku;
  dynamic mrp;
  dynamic retailPrice;
  dynamic sellingPrice;
  dynamic inventory;
  List<Media>? media;
  dynamic hasVideo;
  dynamic video;
  List<OptionalAttributes>? optionalAttributes;
  dynamic sId;

  Variant({
    this.sku,
    this.sellerSku,
    this.mrp,
    this.retailPrice,
    this.sellingPrice,
    this.inventory,
    this.media,
    this.hasVideo,
    this.video,
    this.optionalAttributes,
    this.sId,
  });

  Variant.fromJson(Map<String, dynamic> json) {
    sku = json['sku'];
    sellerSku = json['sellerSku'];
    mrp = json['mrp'];
    retailPrice = json['retailPrice'];
    sellingPrice = json['sellingPrice'];
    inventory = json['inventory'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    video = json['video'];

    if (json['optionalAttributes'] != null) {
      optionalAttributes = <OptionalAttributes>[];
      json['optionalAttributes'].forEach((v) {
        optionalAttributes!.add(OptionalAttributes.fromJson(v));
      });
    }
    sId = json['_id'];
  }
}

class KeyDetails {
  Brand? brand;
  Brand? manufacturer;
  dynamic categoryId;
  dynamic productId;
  dynamic productTitle;
  dynamic productSubTitle;
  dynamic slug;
  dynamic description;
  List<dynamic>? highlights;
  dynamic isCashOnDelivery;
  dynamic hasVariant;
  List<Variant>? variant;
  dynamic hasVideo;
  dynamic video;

  KeyDetails(
      {this.brand,
      this.manufacturer,
      this.categoryId,
      this.productId,
      this.productTitle,
      this.productSubTitle,
      this.slug,
      this.description,
      this.highlights,
      this.isCashOnDelivery,
      this.hasVariant,
      this.variant,
      this.hasVideo,
      this.video});

  KeyDetails.fromJson(Map<String, dynamic> json) {
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    manufacturer = json['manufacturer'] != null
        ? Brand.fromJson(json['manufacturer'])
        : null;

    categoryId = json['categoryId'];
    productId = json['productId'];
    productTitle = json['productTitle'];
    productSubTitle = json['productSubTitle'];
    slug = json['slug'];
    description = json['description'];
    highlights = json['highlights'];
    isCashOnDelivery = json['isCashOnDelivery'];
    hasVariant = json['hasVariant'];
    if (json['variant'] != null) {
      variant = <Variant>[];
      json['variant'].forEach((v) {
        variant!.add(Variant.fromJson(v));
      });
    }
    hasVideo = json['hasVideo'];
    video = json['video'];
  }
}

class Brand {
  dynamic sId;
  dynamic name;

  Brand({this.sId, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}

class FeatureProduct {
  dynamic layoutType;
  dynamic createdAt;
  dynamic description;
  List<dynamic>? listing;
  dynamic slug;
  bool? status;
  dynamic title;
  dynamic updatedAt;
  dynamic id;

  FeatureProduct(
      {this.layoutType,
      this.createdAt,
      this.description,
      this.listing,
      this.slug,
      this.status,
      this.title,
      this.updatedAt,
      this.id});

  FeatureProduct.fromJson(Map<String, dynamic> json) {
    layoutType = json['layoutType'];
    createdAt = json['createdAt'];
    description = json['description'];
    listing = json['listing'];
    slug = json['slug'];
    status = json['status'];
    title = json['title'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }
}

class ListingProduct {
  KeyDetails? keyDetails;
  SellerDetails? sellerDetails;
  ShippingDetails? shippingDetails;
  List<AttributeGroup>? attributeGroup;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic feedback;
  dynamic id;

  ListingProduct(
      {this.keyDetails,
        this.sellerDetails,
        this.shippingDetails,
        this.attributeGroup,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.feedback,
        this.id});

  ListingProduct.fromJson(Map<String, dynamic> json) {
    keyDetails = json['keyDetails'] != null
        ?  KeyDetails.fromJson(json['keyDetails'])
        : null;
    sellerDetails = json['sellerDetails'] != null
        ?  SellerDetails.fromJson(json['sellerDetails'])
        : null;
    shippingDetails = json['shippingDetails'] != null
        ?  ShippingDetails.fromJson(json['shippingDetails'])
        : null;
    if (json['attributeGroup'] != null) {
      attributeGroup = <AttributeGroup>[];
      json['attributeGroup'].forEach((v) {
        attributeGroup!.add( AttributeGroup.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    feedback = json['feedback'];
    id = json['id'];
  }

}

class FeatureProductList {
  dynamic status;
  dynamic message;
  List<FeatureProduct>? featureProduct;
  List<ListingProduct>? listingProduct;

  FeatureProductList(
      {this.status, this.message, this.featureProduct, this.listingProduct});

  FeatureProductList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['featureProduct'] != null) {
      featureProduct = <FeatureProduct>[];
      json['featureProduct'].forEach((v) {
        featureProduct!.add(FeatureProduct.fromJson(v));
      });
    }
    if (json['listingProduct'] != null) {
      listingProduct = <ListingProduct>[];
      json['listingProduct'].forEach((v) {
        listingProduct!.add(ListingProduct.fromJson(v));
      });
    }
  }

  factory FeatureProductList.initial() => FeatureProductList(
      status: -1, message: '', featureProduct: [], listingProduct: []);
}


class ListingItem{
  List<ListingProduct> listingProduct;
  String title;

  ListingItem({
    required this.listingProduct,
    required this.title,
  });
}


