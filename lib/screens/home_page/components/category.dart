import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/shoes_type.dart';

import '../../../components/big_text.dart';
import '../../../utils/dimensions.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key, required this.shoesType,
  }) : super(key: key);

  final List<ShoesTypeModel> shoesType;

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
          children: List.generate(shoesType.length, (index) => GestureDetector(
            onTap: (){
              Get.find<ShoesController>().searchShoesProduct();
            },
            child: Container(
              margin: EdgeInsets.only(right: Dimensions.width10),
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width30,vertical: Dimensions.height10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
              ),
              child: Center(child: BigText(text: shoesType[index].name!,color: Colors.white,fontSize: Dimensions.font18,fontWeight: FontWeight.bold,)),
            ),
          )),
        ),
      ),
        ],
      ),
    );
  }
}
