import 'dart:convert';

import 'package:get/get.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/data/repository/order_repo.dart';
import 'package:store_shoes_app/models/cart_model.dart';

import '../models/order.dart';
import '../models/responseModel.dart';

class OrderController extends GetxController{
  final OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  List<Order> _order = [];
  List<Order> get order => _order;


  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;



  Future<void> getOrderList() async{
    Response response = await orderRepo.getOrderList();
    if(response.statusCode == 200)
    {
      _order = [];
      _order.addAll(OrderList.fromJson(response.body).orders);
      _isLoaded = true;
      update();
    }else{
    print("get order list error");
    }
    update();
   /* _order.forEach((element) {
      element.orderItems!.forEach((element) {
        var testList = [];
          testList.add(jsonEncode(element));
          print(testList[0]);
      });
    });*/
  }

  Future<ResponseModel> placeOrder(String address, int orderAmount,List<Map<String, dynamic>> cart) async {
    Response response = await orderRepo.placeOrder(address, orderAmount,cart);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {

      responseModel = ResponseModel(true, "Done"+response.body["message"]);
    } else {
      responseModel = ResponseModel(false, "Error"+response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<ResponseModel> updateStatusOrder(int idOrder, int status, dynamic body) async{
    Response response = await orderRepo.updateStatusProduct(idOrder, status,body);
    late ResponseModel responseModel;
    if(response.statusCode == 200)
    {
      responseModel = ResponseModel(true, "Success "+response.statusText!);
    }
    else{
      responseModel = ResponseModel(false, "Error "+response.statusText!);
    }
    update();
    return responseModel;

  }
}
