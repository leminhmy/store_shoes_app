import 'package:get/get.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

class ShoesRepo extends GetxService{
  final ApiClient apiClient;
  ShoesRepo({required this.apiClient});

  Future<Response> getShoesProductList()async {
    return await apiClient.getData(AppConstants.SHOES_PRODUCT_URI);
  }
  Future<Response> getShoesTypeList()async {
    return await apiClient.getData(AppConstants.SHOES_TYPE_URI);
  }
}