import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/data/repository/auth_repo.dart';
import 'package:store_shoes_app/data/repository/leather_shoes_prouct_repo.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find()));




  //repos
  Get.lazyPut(() => LeatherShoesProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  
  //controller
  Get.lazyPut(() => LeatherProductController(leatherShoesProductRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
}