import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/controller/cart_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';

import '../../../components/big_text.dart';
import '../../../components/border_radius_widget.dart';
import '../../../components/icon_background_border_radius.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../cart_page.dart';

class AppBarAction extends StatelessWidget {
  const AppBarAction({
    Key? key,
    required this.page, required this.nameCart,
  }) : super(key: key);

  final String page;
  final String nameCart;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
          left: Dimensions.width20,
          right: Dimensions.width20,
          top: Dimensions.height30,
          bottom: Dimensions.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconBackgroundBorderRadius(
            icon: Icons.arrow_back_ios_outlined,
            press: () {
              if (page == "carthistory") {
                Navigator.of(context).pop();
              }
              Get.toNamed(RouteHelper.initial);
            },
            sizeHeight: Dimensions.height40,
            size: Dimensions.iconSize18,
            backgroundColor: AppColors.mainColor,
            iconColor: AppColors.buttonBackgroundColor,
          ),
          Container(
            margin: EdgeInsets.only(right: Dimensions.width10),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width30,vertical: Dimensions.height10),
            decoration: BoxDecoration(
              color: AppColors.btnClickColor,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
            ),
            child: Center(child: BigText(text: nameCart,color: Colors.white,fontSize: Dimensions.font18,fontWeight: FontWeight.bold,)),
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
              SizedBox(
                width: Dimensions.width50,
              ),
              GetBuilder<CartController>(
                  builder: (catController) {
                    return Stack(
                      children: [
                        GestureDetector(
                            onTap: () {
                              print(catController.totalItems);
                            },
                            child: BorderRadiusWidget(
                                widget: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                ))),
                        catController.totalItems >= 1
                            ? Positioned(
                          right: 0,top: 0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              IconBackgroundBorderRadius(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.redColor,
                                sizeHeight: 20,
                                press: () {},
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: BigText(text: catController.totalItems.toString(),color: Colors.white,fontSize: Dimensions.font12,)),
                            ],
                          ),
                        )
                            : Positioned(
                            right: 0,
                            top: 0,
                            child: Container()),
                      ],
                    );
                  }
              ),
            ],
          ),
        ],
      ),
    );
  }
}
