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

  Future<Response> deleteImg(int idProduct,String nameImg)async {
    return await apiClient.postData(AppConstants.PRODUCT_DELETE_URL+"/"+idProduct.toString()+"/img/"+nameImg,{});
  }

  Future<Response> deleteProduct(String idProduct)async {
    return await apiClient.deleteData(AppConstants.PRODUCT_DELETE_URL+"/"+idProduct);
  }
  Future<Response> updateProduct(String idProduct, dynamic body)async {
    return await apiClient.postData(AppConstants.SHOES_UPDATE+"/"+idProduct,body);
  }


  /*//upload file error by getx or by backend data processing error.
  Future<Response> uploadFile(FormData formData)async{
    return await apiClient.postData(AppConstants.UPLOAD_FILE_URI, formData);
  }*/


}