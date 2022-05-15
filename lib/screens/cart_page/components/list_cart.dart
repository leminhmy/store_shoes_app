import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/cart_model.dart';
import 'package:store_shoes_app/routes/route_helper.dart';

import '../../../components/base/no_data_page.dart';
import '../../../controller/cart_controller.dart';
import '../../../utils/colors.dart';
import 'cart_item.dart';

class ListCart extends StatefulWidget {
  const ListCart({
    Key? key, required this.page, required this.index,
  }) : super(key: key);

  final String page;
  final int index;

  @override
  State<ListCart> createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  List<dynamic> _cartList = [];


  void printTestObject(dynamic object){
    var testList = [];
        object.forEach((element) {
        testList.add(jsonEncode(element));
      }
      );
    print(testList);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.page == "cartpage"){
      _cartList = Get.find<CartController>().getItems;

    }else if(widget.page == "carthistory"){
      _cartList = Get.find<OrderController>().order[widget.index].orderItems!;
      // dynamic cartlisttest = Get.find<CartController>().getItems;
      // printTestObject(cartlisttest);
    }


  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {

      return _cartList.isNotEmpty?Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: List.generate(
            _cartList.length,
                (index) =>
                GestureDetector(
                  onTap: (){
                  },
                    child: CartItem(page: widget.page,cartModel: _cartList[index])),
          ),
        ),
      ):NoDataPage(text: "Your cart is empty");
    });
  }
}
