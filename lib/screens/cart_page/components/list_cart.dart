import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';

import '../../../components/base/no_data_page.dart';
import '../../../controller/cart_controller.dart';
import '../../../utils/colors.dart';
import 'cart_item.dart';

class ListCart extends StatelessWidget {
  const ListCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      var _cartList = cartController.getItems;
      return _cartList.length>0?Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: List.generate(
            cartController.getItems.length,
                (index) =>
                GestureDetector(

                    child: CartItem(cartModel: cartController.getItems[index])),
          ),
        ),
      ):NoDataPage(text: "Your cart is empty");
    });
  }
}
