import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/product.dart';

import '../../../components/big_text.dart';
import '../../../components/border_radius_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key, required this.shoesController, required this.productShoesDetail,
  }) : super(key: key);

  final ShoesController shoesController;
  final ProductsModel productShoesDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height50 * 2,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensions.radius20),
          topLeft: Radius.circular(Dimensions.radius20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.height5,horizontal: Dimensions.width15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              border: Border.all(
                color: Colors.white,
                width: 1,
              )
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    shoesController.setQuantity(false);
                  },
                  child: BorderRadiusWidget(
                    colorBackground: AppColors.greenColor,
                    widget: Icon(
                      Icons.remove_outlined,
                      color: Colors.white,
                      size: Dimensions.font26,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                BigText(
                  text: "x${shoesController.inCarItems.toString()}",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font26,
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: (){
                    shoesController.setQuantity(true);
                  },
                  child: BorderRadiusWidget(
                    colorBackground: AppColors.greenColor,
                    widget: Icon(
                      Icons.add_outlined,
                      color: Colors.white,
                      size: Dimensions.font26,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              shoesController.addItem(productShoesDetail);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.height10,horizontal: Dimensions.width20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: BigText(
                text: "Add to cart",
                color: Colors.white,
                fontSize: Dimensions.font26,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
