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
  static const String getSingleItemListFromCategory = "${baseUrl}category";

  //Login
  static const String loginUsingCredentials = "${baseUrl}auth/login";
  static const String loginWithPhoneNumber = "${baseUrl}customer/otp";

  static const String verifyLoginWithPhoneNumberOtp = "${baseUrl}auth/m/login";

  //Register
  static const String registerNewPhoneNumber = "${baseUrl}customer/newOtp";
  static const String verifyNewRegisterWithOtp = "${baseUrl}customer";

  //Forgot password
  static const String getForgotPasswordOtp = "${baseUrl}customer/forgot";

  //WishList
  static const String toggleWishList = "${baseUrl}wishlist";
  static const String verifyWishList = "${baseUrl}auth/login/success";

  //CartList
  static const String getCartList = "${baseUrl}cart";
  static const String addAddress = "${baseUrl}customerAddress";
  static const String getOrderInit = "${baseUrl}order/init";

  static const String applyCoupon = "${baseUrl}offer";

  static const String makeOrder = "${baseUrl}order/";

  static const String verifyOtp = "${baseUrl}order/verifyOtp";

  static const String savePaymentSuccess = "${baseUrl}order/verifyOrder";

  static const String getMyOrder = "${baseUrl}order/listing";


















}
