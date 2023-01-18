class EventResponse {
  int? status;
  String? message;
  OrderData? orderData;
  OrderItem? orderItem;
  Payment? payment;
  PaymentData? paymentData;

  EventResponse(
      {status,
        message,
        orderData,
        orderItem,
        payment,
        paymentData});

  EventResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    orderData = json['orderData'] != null
        ?  OrderData.fromJson(json['orderData'])
        : null;
    orderItem = json['orderItem'] != null
        ?  OrderItem.fromJson(json['orderItem'])
        : null;
    payment =
    json['payment'] != null ?  Payment.fromJson(json['payment']) : null;
    paymentData = json['paymentData'] != null
        ?  PaymentData.fromJson(json['paymentData'])
        : null;
  }


}

class OrderData {
  String? orderId;
  String? customerId;
  int? amount;
  int? actualAmountToPay;
  Wallet? wallet;
  ShippingAddress? shippingAddress;
  String? shipping;
  String? tax;
  String? emailId;
  String? date;
  bool? shipped;
  ShippingAddress? deliveryAddress;
  String? paymentType;
  String? isPayment;
  String? paymentId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? id;

  OrderData(
      {orderId,
        customerId,
        amount,
        actualAmountToPay,
        wallet,
        shippingAddress,
        shipping,
        tax,
        emailId,
        date,
        shipped,
        deliveryAddress,
        paymentType,
        isPayment,
        paymentId,
        status,
        createdAt,
        updatedAt,
        id});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    customerId = json['customerId'];
    amount = json['amount'];
    actualAmountToPay = json['actualAmountToPay'];
    wallet =
    json['wallet'] != null ?  Wallet.fromJson(json['wallet']) : null;
    shippingAddress = json['shippingAddress'] != null
        ?  ShippingAddress.fromJson(json['shippingAddress'])
        : null;
    shipping = json['shipping'];
    tax = json['tax'];
    emailId = json['emailId'];
    date = json['date'];
    shipped = json['shipped'];
    deliveryAddress = json['deliveryAddress'] != null
        ?  ShippingAddress.fromJson(json['deliveryAddress'])
        : null;
    paymentType = json['paymentType'];
    isPayment = json['isPayment'];
    paymentId = json['paymentId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  
}

class Wallet {
  bool? isUsed;

  Wallet({isUsed});

  Wallet.fromJson(Map<String, dynamic> json) {
    isUsed = json['isUsed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['isUsed'] = isUsed;
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


}

class OrderItem {
  String? orderItemId;
  String? orderItemUnitId;
  String? orderId;
  String? customerId;
  String? productId;
  String? sellerId;
  String? sellerTIN;
  String? sellerGSTIN;
  String? gstHSNCode;
  String? productTitle;
  String? price;
  TaxDetails? taxDetails;
  String? sku;
  String? qty;
  String? status;
  bool? isDelete;
  bool? hasReviewed;
  String? createdAt;
  String? updatedAt;
  String? id;

  OrderItem(
      {orderItemId,
        orderItemUnitId,
        orderId,
        customerId,
        productId,
        sellerId,
        sellerTIN,
        sellerGSTIN,
        gstHSNCode,
        productTitle,
        price,
        taxDetails,
        sku,
        qty,
        status,
        isDelete,
        hasReviewed,
        createdAt,
        updatedAt,
        id});

  OrderItem.fromJson(Map<String, dynamic> json) {
    orderItemId = json['orderItemId'];
    orderItemUnitId = json['orderItemUnitId'];
    orderId = json['orderId'];
    customerId = json['customerId'];
    productId = json['productId'];
    sellerId = json['sellerId'];
    sellerTIN = json['sellerTIN'];
    sellerGSTIN = json['sellerGSTIN'];
    gstHSNCode = json['gstHSNCode'];
    productTitle = json['productTitle'];
    price = json['price'];
    taxDetails = json['taxDetails'] != null
        ?  TaxDetails.fromJson(json['taxDetails'])
        : null;
    sku = json['sku'];
    qty = json['qty'];
    status = json['status'];
    isDelete = json['isDelete'];
    hasReviewed = json['hasReviewed'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

 
}

class TaxDetails {
  String? gstCategory;
  int? gstTaxRateCGST;
  int? gstTaxRateSGST;
  int? gstTaxRateIGST;
  String? gstTaxName;
  int? gstTaxBase;
  int? gstTaxTotal;
  int? gstTaxAmtCGST;
  int? gstTaxAmtSGST;
  int? gstTaxAmtIGST;

  TaxDetails(
      {gstCategory,
        gstTaxRateCGST,
        gstTaxRateSGST,
        gstTaxRateIGST,
        gstTaxName,
        gstTaxBase,
        gstTaxTotal,
        gstTaxAmtCGST,
        gstTaxAmtSGST,
        gstTaxAmtIGST});

  TaxDetails.fromJson(Map<String, dynamic> json) {
    gstCategory = json['gstCategory'];
    gstTaxRateCGST = json['gstTaxRateCGST'];
    gstTaxRateSGST = json['gstTaxRateSGST'];
    gstTaxRateIGST = json['gstTaxRateIGST'];
    gstTaxName = json['gstTaxName'];
    gstTaxBase = json['gstTaxBase'];
    gstTaxTotal = json['gstTaxTotal'];
    gstTaxAmtCGST = json['gstTaxAmtCGST'];
    gstTaxAmtSGST = json['gstTaxAmtSGST'];
    gstTaxAmtIGST = json['gstTaxAmtIGST'];
  }


}

class Payment {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? offerId;
  List<String>? offers;
  String? status;
  int? attempts;
  List<Null>? notes;
  int? createdAt;

  Payment(
      {id,
        entity,
        amount,
        amountPaid,
        amountDue,
        currency,
        receipt,
        offerId,
        offers,
        status,
        attempts,
        notes,
        createdAt});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    offerId = json['offer_id'];
    offers = json['offers'].cast<String>();
    status = json['status'];
    attempts = json['attempts'];
   
    createdAt = json['created_at'];
  }


}

class PaymentData {
  String? paymentType;
  String? gateway;
  PaymentResponse? paymentResponse;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? id;

  PaymentData(
      {paymentType,
        gateway,
        paymentResponse,
        status,
        createdAt,
        updatedAt,
        id});

  PaymentData.fromJson(Map<String, dynamic> json) {
    paymentType = json['paymentType'];
    gateway = json['gateway'];
    paymentResponse = json['paymentResponse'] != null
        ?  PaymentResponse.fromJson(json['paymentResponse'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

 
}

class PaymentResponse {
  String? id;
  String? entity;
  int? amount;
  bool? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? name;
  String? key;
  String? status;
  int? attempts;
  String? offerId;
  int? createdAt;

  PaymentResponse(
      {id,
        entity,
        amount,
        amountPaid,
        amountDue,
        currency,
        receipt,
        name,
        key,
        status,
        attempts,
        offerId,
        notes,
        createdAt});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    name = json['name'];
    key = json['key'];
    status = json['status'];
    attempts = json['attempts'];
    offerId = json['offer_id'];
    createdAt = json['created_at'];
  }

 
}
