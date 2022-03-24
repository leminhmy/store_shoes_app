import 'package:get/get.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/data/repository/leather_shoes_prouct_repo.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

Future<void> init() async{
  
  
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //api client



  //repos
  Get.lazyPut(() => LeatherShoesProductRepo(apiClient: Get.find()));
  
  //controller
  Get.lazyPut(() => LeatherProductController(leatherShoesProductRepo: Get.find()));
}