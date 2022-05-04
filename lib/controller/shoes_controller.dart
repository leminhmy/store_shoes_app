import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/shoes_repo.dart';
import 'package:store_shoes_app/models/product.dart';

import '../models/cart_model.dart';
import '../models/responseModel.dart';
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

  //chose option product(size-color)
  String _optionColor = "0xFFFFFFFF";
  String get optionColor => _optionColor;
  int _optionSize = 10;
  int get optionSize => _optionSize;


  void setDefaultSizeAndColor(int size, String color){
    _optionSize = size;
    _optionColor = color;
  }

  void changeOptionSize(int value){
    _optionSize = value;
    update();
  }

  void updateWidget(){

    update();
  }

  void changeOptionColor(String value){
    _optionColor = value;
    update();
  }



  /*//eror post file to backend by getx
  Future<ResponseModel> uploadFile(FormData formData) async {

    Response response = await shoesRepo.uploadFile(formData);

    late ResponseModel responseModel;
    if (response.statusCode == 200) {

      print(response.statusCode);
      responseModel = ResponseModel(true, "Success "+response.statusText!);
    } else {
      print(jsonEncode(response.body));
      responseModel = ResponseModel(false, "Error "+response.statusText!);
    }
    update();
    return responseModel;
  }*/

  Future<ResponseModel> updateProduct(String idProduct,Map body) async{
    Response response = await shoesRepo.updateProduct(idProduct, body);
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

  Future<ResponseModel> deleteImg(int idProduct, String nameImg) async{
    Response response = await shoesRepo.deleteImg(idProduct, nameImg);
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
    update();
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
    _optionColor = '0xFFFFFFFF';
    _optionSize = 10;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    // print("exist or not"+exist.toString());
    List<CartModel> list = _cart.getItems;
    int index = list.indexWhere((element) => element.id! == product.id!);
    if(exist){
      _inCartItems = _cart.getQuantity(product);
      _optionColor = list[index].color!;
      _optionSize = list[index].size!;
    }
    // print("the quantity in the cart is "+_inCartItems.toString());
  }

  void addItem(ProductsModel product){
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      value.size = _optionSize;
      value.color = _optionColor.toString();
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