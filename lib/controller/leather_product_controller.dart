

import 'dart:convert';

import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/leather_shoes_prouct_repo.dart';

import '../models/product.dart';

class LeatherProductController extends GetxController{
  final LeatherShoesProductRepo leatherShoesProductRepo;

  LeatherProductController({required this.leatherShoesProductRepo});
  List<dynamic> _leatherProductList = [];
  List<dynamic> get leatherProductList => _leatherProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getLeatherProductList() async{
    Response response = await leatherShoesProductRepo.getLeatherShoesProductList();
    if(response.statusCode == 200)
      {
          _leatherProductList = [];
          _leatherProductList.addAll(Product.fromJson(response.body).products);
          _isLoaded = true;
          update();
      }else{

    }
    
    // _leatherProductList.forEach((element) {
    //   var testList = [];
    //   testList.add(jsonEncode(element));
    //   print(testList);
    // });
  }
}