import 'package:flutter/material.dart';
import 'package:store_shoes_app/routes/route_helper.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              BigText(text: "Đức lợi Store"),
              Row(
                children: [
                  SmallText(text: "Chi nhánh PY",),
                  Icon(Icons.arrow_drop_down_outlined,color: Colors.black,size: Dimensions.iconSize16,),
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: ()=> Get.toNamed(RouteHelper.getSearchPage()),
            child: Container(
              height: Dimensions.height50,
              width: Dimensions.width50,
              padding: EdgeInsets.all(Dimensions.width10),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius10),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: Dimensions.iconSize26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
