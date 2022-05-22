import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/routes/route_helper.dart';

import '../../../components/big_text.dart';
import '../../../components/icon_background_border_radius.dart';
import '../../../controller/leather_product_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class HearderAppBar extends StatelessWidget {
  const HearderAppBar({
    Key? key, required this.namePage,
  }) : super(key: key);

  final String namePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height50 * 2,
      color: AppColors.mainColor,
      padding: EdgeInsets.only(top: Dimensions.height15 * 3),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BigText(
            text: namePage,
            color: Colors.white,
          ),
          IconBackgroundBorderRadius(
            icon: Icons.shopping_cart_outlined,
            press: () {
              Get.toNamed(RouteHelper.getCartPage("cartpage",));
              // Get.find<CartController>().getItemsTest;
              // Get.find<CartController>().clear();
            },
            size: Dimensions.width20,
          ),
        ],
      ),
    );
  }
}
