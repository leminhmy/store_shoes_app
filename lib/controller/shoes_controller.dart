import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/shoes_repo.dart';
import 'package:store_shoes_app/models/product.dart';

import '../models/cart_model.dart';
import '../models/shoes_type.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class ShoesController extends GetxController{
  final ShoesRepo shoesRepo;

  ShoesController({required this.shoesRepo});
  List<ProductsModel> _shoesProductList = [];
  List<ProductsModel> get shoesProductList => _shoesProductList;

  List<ShoesTypeModel> _shoesTypeList = [];
  List<ShoesTypeModel> get shoesTypeList => _shoesTypeList;

  List<ProductsModel> _listFilterShoes = [];
  List<ProductsModel> get listFilterShoes => _listFilterShoes;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItems = 0;
  int get inCarItems => _inCartItems+_quantity;
  late CartController _cart;

  int indexSelected = 0;


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
    }
    );*/
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

   /* _shoesTypeList.forEach((element) {
      var testList = [];
      testList.add(jsonEncode(element));
      print(testList);
    });*/
  }

  Future<void> searchShoesProduct(int index)async {
    _listFilterShoes = [];
    _shoesProductList.forEach((element) {
      if(element.typeId == index)
        {
          _listFilterShoes.add(element);
        }
    });
    indexSelected = index;
    update();
  }

  void setListFilterShoes(){
    _listFilterShoes = [];
    indexSelected = 0;
    update();
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity+1);
    }else{
      _quantity = checkQuantity(_quantity-1);
    }
    print(_inCartItems);
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0){
      Get.snackbar("Item count", "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems+quantity)>20){
      Get.snackbar("Item count", "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }
  void initProduct(ProductsModel product, CartController cart){
    _quantity =0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    // print("exist or not"+exist.toString());
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    // print("the quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductsModel product){
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is "+value.id.toString()+" The quantity is "+ value.quantity.toString());
    });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}