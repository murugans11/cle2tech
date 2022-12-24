class CartRequest {
  String? action;
  List<Items>? items;

  CartRequest({this.action, this.items});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? sku;
  int? qty;

  Items({this.sku, this.qty});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sku'] = sku;
    data['qty'] = qty;
    return data;
  }
}
