import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';

import '../../../components/big_text.dart';
import '../../../components/button_border_radius.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class BottomBarCart extends StatelessWidget {
  const BottomBarCart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height30*4,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width20, vertical: Dimensions.height30),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius30),
            topRight: Radius.circular(Dimensions.radius30)),
      ),
      child: GetBuilder<CartController>(
        builder: (cartController) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //quantity
              ButtonBorderRadius(
                  widget: BigText(
                    text: "\$ ${cartController.totalAmount}",
                    color: Colors.black,
                  )),
              //addToCard
              GestureDetector(
                onTap: (){
                },
                child: ButtonBorderRadius(
                  widget: BigText(
                    text: "Check out",
                    color: Colors.white,
                  ),
                  colorBackground: AppColors.mainColor,
                ),
              )
            ],
          );
        }
      ),
    );
  }
}