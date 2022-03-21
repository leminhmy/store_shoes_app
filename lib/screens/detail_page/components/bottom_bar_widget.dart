import 'package:flutter/material.dart';

import '../../../components/big_text.dart';
import '../../../components/border_radius_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
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
                BorderRadiusWidget(
                  colorBackground: AppColors.greenColor,
                  widget: Icon(
                    Icons.remove_outlined,
                    color: Colors.white,
                    size: Dimensions.font26,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                BigText(
                  text: "X4",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font26,
                ),
                SizedBox(
                  width: 10,
                ),
                BorderRadiusWidget(
                  colorBackground: AppColors.greenColor,
                  widget: Icon(
                    Icons.add_outlined,
                    color: Colors.white,
                    size: Dimensions.font26,
                  ),
                ),
              ],
            ),
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
