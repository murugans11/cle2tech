import '../feature/feature_productes.dart';

class CategorieItems {
  int? status;
  String? message;
  Paginator? paginator;
  late List<ListingProduct> listingProduct;
  Category? category;

  CategorieItems({
    this.status,
    this.paginator,
    required this.listingProduct,
    this.message,
    this.category,
  });

  CategorieItems.fromJson(Map<String, dynamic> json) {
    listingProduct = <ListingProduct>[];
    status = json['status'];
    paginator = json['paginator'] != null
        ? Paginator.fromJson(json['paginator'])
        : null;
    if (json['listingProduct'] != null) {
      json['listingProduct'].forEach((v) {
        listingProduct.add(ListingProduct.fromJson(v));
      });
    }
    message = json['message'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  factory CategorieItems.initial() => CategorieItems(
        status: -1,
        message: '',
        paginator: Paginator(),
        listingProduct: <ListingProduct>[],
        category: Category(),
      );
}

class Paginator {
  int? itemCount;
  int? perPage;
  int? pageCount;
  int? currentPage;
  int? slNo;
  bool? hasPrevPage;
  bool? hasNextPage;
  int? prev;
  int? next;

  Paginator(
      {this.itemCount,
      this.perPage,
      this.pageCount,
      this.currentPage,
      this.slNo,
      this.hasPrevPage,
      this.hasNextPage,
      this.prev,
      this.next});

  Paginator.fromJson(Map<String, dynamic> json) {
    itemCount = json['itemCount'];
    perPage = json['perPage'];
    pageCount = json['pageCount'];
    currentPage = json['currentPage'];
    slNo = json['slNo'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prev = json['prev'];
    next = json['next'];
  }
}

class Category {
  String? name;
  String? displayName;
  String? description;
  String? parentId;
  String? path;
  String? pathId;
  dynamic category;
  String? parentCategory;
  bool? status;
  String? createdAt;
  String? updatedAt;
  bool? isDelete;
  String? id;

  Category(
      {this.name,
      this.displayName,
      this.description,
      this.parentId,
      this.path,
      this.pathId,
      this.category,
      this.parentCategory,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.isDelete,
      this.id});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    parentId = json['parentId'];
    path = json['path'];
    pathId = json['pathId'];
    category = json['category'];
    parentCategory = json['parentCategory'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isDelete = json['isDelete'];
    id = json['id'];
  }
}

class CategoryItemDisplay {
  String? path;
  String? displayName;
  String? name;
  List<Category1>? categorieItemList;

  CategoryItemDisplay({
    this.name,
    this.displayName,
    this.path,
    this.categorieItemList,
  });
}

class Category1 {
  String? path;
  String? displayName;
  String? name;

  Category1({
    this.name,
    this.displayName,
    this.path,
  });
}
