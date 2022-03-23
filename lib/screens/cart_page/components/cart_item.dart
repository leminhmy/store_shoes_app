import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Dimensions.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image product
          Container(
            height: Dimensions.pageViewTextContainer,
            width: Dimensions.pageViewTextContainer,
            decoration: BoxDecoration(
              color: AppColors.greenColor,
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              image: DecorationImage(
                image: AssetImage("assets/images/a2.png"),
                fit: BoxFit.cover
              )
            ),
          ),
          //information product
          Expanded(
            child: Container(
              padding: EdgeInsets.all(Dimensions.width10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.radius10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.paraColor.withOpacity(0.1),
                      blurRadius: 1,
                    ),

                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(text: "Name Shoes"),
                  SizedBox(height: Dimensions.height5,),
                  SmallText(text: "Spicy"),
                  SizedBox(height: Dimensions.height5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: "\$ 19999",
                        color: AppColors.redColor,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          BigText(text: "5"),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          InkWell(
                            onTap: () {
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.signColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
