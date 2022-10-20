class Endpoints {
  Endpoints._();

  // base url
  //static const String baseUrl = "http://jsonplaceholder.typicode.com/posts";

  static const String baseUrl = "http://ss.api.shopeein.com/api/v1/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getHomePageBanner = "${baseUrl}banner";
  static const String getFeatureProductList = "${baseUrl}featureProduct";
  static const String getCategoryGroup = "${baseUrl}categoryGroup";
  static const String getViewAllCategoryProductList = "${baseUrl}category";
  static const String getCategoryProductListByName = "${baseUrl}categoryGroup";
}
