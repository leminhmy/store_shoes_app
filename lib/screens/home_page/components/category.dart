import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/shoes_type.dart';
import 'package:store_shoes_app/utils/app_contants.dart';
import 'package:store_shoes_app/utils/colors.dart';

import '../../../components/big_text.dart';
import '../../../utils/dimensions.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key, required this.shoesType, required this.shoesController,
  }) : super(key: key);

  final List<ShoesTypeModel> shoesType;
  final ShoesController shoesController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: "Category",fontWeight: FontWeight.bold,color: Colors.black,fontSize: Dimensions.font26,),
          SizedBox(height: Dimensions.height5,),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: (){
                shoesController.setListFilterShoes();
              },
              child: Container(
                margin: EdgeInsets.only(right: Dimensions.width10),
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width30,vertical: Dimensions.height10),
                decoration: BoxDecoration(
                  color: shoesController.indexSelected==0?AppColors.btnClickColor:Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
                ),
                child: Center(child: BigText(text: "All",color: Colors.white,fontSize: Dimensions.font18,fontWeight: FontWeight.bold,)),
              ),
            ),
            Row(
              children: List.generate(shoesType.length, (index) => GestureDetector(
                onTap: (){
                  shoesController.searchShoesProduct(shoesType[index].id!);
                },
                child: Container(
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30,vertical: Dimensions.height10),
                  decoration: BoxDecoration(
                    color: shoesController.indexSelected==shoesType[index].id?AppColors.btnClickColor:Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
                  ),
                  child: Center(child: BigText(text: shoesType[index].name!,color: Colors.white,fontSize: Dimensions.font18,fontWeight: FontWeight.bold,)),
                ),
              )),
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }
}
