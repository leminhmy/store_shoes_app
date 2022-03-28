import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/shoes_repo.dart';
import 'package:store_shoes_app/models/product.dart';

import '../models/shoes_type.dart';

class ShoesController extends GetxController{
  final ShoesRepo shoesRepo;

  ShoesController({required this.shoesRepo});
  List<ProductsModel> _shoesProductList = [];
  List<ProductsModel> get shoesProductList => _shoesProductList;
  List<ProductsModel> _shoesProductListSearch = [];
  List<ProductsModel> get shoesProductListSearch => _shoesProductListSearch;
  List<ShoesTypeModel> _shoesTypeList = [];
  List<ShoesTypeModel> get shoesTypeList => _shoesTypeList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getShoesProductList() async{
    Response response = await shoesRepo.getShoesProductList();
    if(response.statusCode == 200)
      {
        _shoesProductList = [];
        _shoesProductList.addAll(Product.fromJson(response.body).products);
        _isLoaded = true;
        update();

      }
    else{
      print("get shoes product error");
    }

   /* _shoesProductList.forEach((element) {
      var testList = [];
      testList.add(jsonEncode(element));
      print(testList);
    });*/
  }
  Future<void> getShoesTypeList() async{
    Response response = await shoesRepo.getShoesTypeList();
    if(response.statusCode == 200)
    {
      _shoesTypeList = [];
      _shoesTypeList.addAll(ShoesType.fromJson(response.body).shoesType);
      _isLoaded = true;
      update();

    }
    else{
      print("get shoes type error");
    }

    _shoesTypeList.forEach((element) {
      var testList = [];
      testList.add(jsonEncode(element));
      print(testList);
    });
  }

  Future<void> searchShoesProduct()async {
    var testList = [];
    _shoesProductList.forEach((element) {
      if(element.typeId == 1)
        {
          testList.add(jsonEncode(element));
        }
    });
    print(testList);
  }
}