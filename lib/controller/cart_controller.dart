import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/cart_repo.dart';

import '../models/cart_model.dart';
import '../models/product.dart';
import '../utils/colors.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;

  CartController({required this.cartRepo});


  Map<int, CartModel> _items = {};
  Map<int, CartModel> _itemsHistory = {};

  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems=[];


  void addItem(ProductsModel product, int quantity) {
    if (_items.containsKey(product.id!)) {
      var totalQuantity = 0;
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });

      if (totalQuantity <= 0) {
        //check delete item
        Get.defaultDialog(
          title: "You want delete it!",
          onConfirm: (){
            _items.remove(product.id);
            //update storageCart.
            cartRepo.addToCartList(getItems);
            update();
            Get.back();
          },
          onWillPop: ()async{
            _items.update(product.id!, (value) {
              return CartModel(
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity: value.quantity! + 1,
                isExist: true,
                time: DateTime.now().toString(),
                product: product,
              );
            });
            //update storageCart.
            cartRepo.addToCartList(getItems);
            update();
            return true;
          },
          onCancel: (){
            _items.update(product.id!, (value) {
              return CartModel(
                id: value.id,
                name: value.name,
                price: value.price,
                img: value.img,
                quantity: value.quantity! + 1,
                isExist: true,
                time: DateTime.now().toString(),
                product: product,
              );
            });
            //update storageCart.
            cartRepo.addToCartList(getItems);
            update();
          },
          textConfirm: "Yes",
          textCancel: "No",
          content: Text("Select"),
        );

      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "Item count",
          "You should at least add an item in the cart !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    //update storageCart.
    cartRepo.addToCartList(getItems);
    update();
  }


  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  int getQuantity(ProductsModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  set setCart(List<CartModel> items){
    storageItems=items;
    // print("Length of cart items " + storageItems.length.toString());
    for(int i=0; i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }

  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  int get totalAmount{
    var total =0;
    _items.forEach((key, value) {
      total += value.quantity!*value.price!;
    });
    return total;
  }

  bool existInCart(ProductsModel products) {
    if (_items.containsKey(products.id)) {
      return true;
    }
    return false;
  }


  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  set setItemsHistory(Map<int, CartModel> setItems){
    _itemsHistory = {};
    _itemsHistory = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  //cart historry
  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }


  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCarthistory();
    update();
  }

}