import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';

import '../../../components/big_text.dart';
import '../../../components/icon_background_border_radius.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../cart_page.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    Key? key, required this.page,
  }) : super(key: key);

  final String page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height30,bottom: Dimensions.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBackgroundBorderRadius(
            icon: Icons.arrow_back_ios_outlined,
            press: () {
                if(page == "carthistory"){
                  Get.back();
                }
                Get.toNamed(RouteHelper.initial);
            },
            sizeHeight: Dimensions.height40,
            size: Dimensions.iconSize18,
            backgroundColor: AppColors.mainColor,
            iconColor: AppColors.buttonBackgroundColor,
          ),
          Row(
            children: [
              IconBackgroundBorderRadius(
                icon: Icons.home_outlined,
                press: () {
                  Get.toNamed(RouteHelper.initial);
                },
                sizeHeight: Dimensions.height40,
                size: Dimensions.iconSize24,
                backgroundColor: AppColors.mainColor,
                iconColor: AppColors.buttonBackgroundColor,
              ),
              SizedBox(width: Dimensions.width50,),
               Stack(
        children: [
          IconBackgroundBorderRadius(
            icon: Icons.shopping_cart_outlined,
            press: () {
              Get.find<CartController>().getItemsTest;
              print("taped");
            },
            sizeHeight: Dimensions.height40,
            size: Dimensions.iconSize18,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
          ),
          Positioned(
            right: 0,top: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconBackgroundBorderRadius(
                  icon: Icons.circle,
                  size: 20,
                  iconColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  sizeHeight: 20,
                  press: () {},
                ),
                Align(
                    alignment: Alignment.center,
                    child: BigText(text: Get.find<ShoesController>().totalItems >= 1?Get.find<ShoesController>().totalItems.toString():"0",color: AppColors.redColor,fontSize: Dimensions.font12,)),
              ],
            ),
          )
        ],
      ),

            ],
          ),

        ],
      ),
    );
  }
}
