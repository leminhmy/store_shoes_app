import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/data/repository/auth_repo.dart';
import 'package:store_shoes_app/data/repository/leather_shoes_prouct_repo.dart';
import 'package:store_shoes_app/data/repository/shoes_repo.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

import '../controller/cart_controller.dart';
import '../data/repository/cart_repo.dart';

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
  
  //controller
  Get.lazyPut(() => ShoesController(shoesRepo: Get.find()));
  Get.lazyPut(() => LeatherProductController(leatherShoesProductRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}