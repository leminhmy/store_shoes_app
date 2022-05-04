import 'package:get/get.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

class LeatherShoesProductRepo extends GetxService{
  final ApiClient apiClient;
  LeatherShoesProductRepo({required this.apiClient});
  
  Future<Response> getLeatherShoesProductList()async {
    return await apiClient.getData(AppConstants.LEATHER_PRODUCT_URI);
  }
}