import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/controller/map_controller.dart';
import 'package:store_shoes_app/controller/messages_controller.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/data/repository/auth_repo.dart';
import 'package:store_shoes_app/data/repository/leather_shoes_prouct_repo.dart';
import 'package:store_shoes_app/data/repository/map_json_repo.dart';
import 'package:store_shoes_app/data/repository/messages_repo.dart';
import 'package:store_shoes_app/data/repository/order_repo.dart';
import 'package:store_shoes_app/data/repository/shoes_repo.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

import '../controller/cart_controller.dart';
import '../controller/user_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/user_repo.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));

  //repos
  Get.lazyPut(() => ShoesRepo(apiClient: Get.find()));
  Get.lazyPut(() => LeatherShoesProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => MessagesRepo(apiClient: Get.find()));
  Get.lazyPut(() => MapJsonRepo(apiClient: Get.find()));

  //controller
  Get.lazyPut(() => ShoesController(shoesRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LeatherProductController(leatherShoesProductRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => MessagesController(messagesRepo: Get.find()));
  Get.lazyPut(() => MapController(mapJsonRepo: Get.find()));

}