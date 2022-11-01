import '../feature/feature_productes.dart';

class WishListResponse {
  int? status;
  String? message;
  List<ListingProduct>? listingProduct;

  WishListResponse({this.status, this.message, this.listingProduct});

  WishListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['listingProduct'] != null) {
      listingProduct = <ListingProduct>[];
      json['listingProduct'].forEach((v) {
        listingProduct!.add(ListingProduct.fromJson(v));
      });
    }
  }
}
