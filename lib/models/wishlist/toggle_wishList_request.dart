class ToggleWishListRequest {

  late final String productId;
  late final String sku;
  late final String action;

  ToggleWishListRequest({
    required this.productId,
    required this.sku,
    required this.action,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productId'] = productId;
    data['sku'] = sku;
    data['action'] = action;
    return data;
  }
}