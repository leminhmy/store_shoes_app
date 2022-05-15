import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../models/cart_model.dart';
import '../../utils/app_contants.dart';
class OrderRepo{
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> getOrderList()async {
    return await apiClient.getData(AppConstants.ORDER_URI);
  }

  Future<Response> placeOrder(String address, int order_amount, List<Map<String, dynamic>> cart)async{
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, {"address":address,"order_amount":order_amount,"cart": cart});
  }

  Future<Response> updateStatusProduct(int idOrder,int status,dynamic body)async {
    return await apiClient.putData(AppConstants.SHOES_UPDATE+"/"+idOrder.toString()+"/status/"+status.toString(),body);
  }
}