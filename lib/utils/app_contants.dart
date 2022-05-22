class AppConstants{
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;


  //product
  static const String BASE_URL = "http://192.168.1.7/";
  static const String UPLOAD_URL = "uploads/";
  static const String LEATHER_PRODUCT_URI = "api/v1/products/leather";
  static const String SHOES_PRODUCT_URI = "api/v1/products/shoes";
  static const String SHOES_TYPE_URI = "api/v1/products/shoes-types";
  static const String SHOES_UPDATE = "api/v1/products/update";


  //auth and user end points
  static const String REGISTRATION_URI = "api/v1/auth/register";
  static const String LOGIN_URI = "api/v1/auth/login";
  static const String USER_INFO_URI = "api/v1/customer/info";

  //order
  static const String ORDER_URI = "api/v1/order/list";
  static const String ORDER_ADMIN_URI = "api/v1/order/listadmin";
  static const String PLACE_ORDER_URI = "api/v1/order/place";


  //uploadfile
  static const String UPLOAD_FILE_URI = "api/v1/products/uploadfile";
  static const String ADD_PRODUCT_URI = "api/v1/products/add";

  //messages
  static const String MESSAGES_GET_URI = "api/v1/messaging/get";
  static const String MESSAGES_SEND_URI = "api/v1/messaging/send";

  //map
  static const String MAP_PROVINE_URI = "api/v1/map/provine";
  static const String MAP_DISTRICT_URI = "api/v1/map/district";
  static const String MAP_COMMUNE_URI = "api/v1/map/commune";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";




  //delete
  static const String PRODUCT_DELETE_URL = "api/v1/products/delete";

}