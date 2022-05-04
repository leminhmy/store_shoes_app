import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/base/app_variable.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../models/product.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class InfoProduct extends StatelessWidget {
  const InfoProduct({
    Key? key, required this.shoesProduct, required this.listSize, required this.listColor, required this.shoesController,
  }) : super(key: key);

  final ProductsModel shoesProduct;
  final List<int> listSize;
  final List<String> listColor;
  final ShoesController shoesController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: shoesProduct.name!,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font26,
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Row(
                children: [
                  Row(
                    children: List.generate(5, (index) =>
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.width5),
                          child: Icon(Icons.star, color: Colors.yellow,
                            size: Dimensions.iconSize26,),
                        )),
                  ),
                  SizedBox(
                    width: Dimensions.width10,
                  ),
                  SmallText(text: "4.0", fontSize: Dimensions.font20,),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.height10,
                        horizontal: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20 *
                                1.2), bottomLeft: Radius.circular(Dimensions
                            .radius20 * 1.2)),
                        border: Border.all(
                          width: 1.5,
                          color: Colors.grey,
                        )
                    ),
                    child: Center(child: Row(
                      children: [
                        BigText(text: AppVariable().numberFormatPriceVi(shoesProduct.price!),
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,),
                      ],
                    )),
                  )
                ],
              ),
              SizedBox(
                height: Dimensions.height5,
              ),
              BigText(text: "Description"),
              SmallText(
                  text: shoesProduct.description!),
              SizedBox(
                height: Dimensions.height10,
              ),

            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: BigText(text: "Size"),
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.width15),
            child: Row(
              children: List.generate(listSize.length, (index) =>
                  GestureDetector(
                    onTap: (){
                      shoesController.changeOptionSize(listSize[index]);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: Dimensions.width5),
                      child: Container(
                        height: Dimensions.height50,
                        width: Dimensions.width50,
                        decoration: BoxDecoration(
                            color: listSize[index] == shoesController.optionSize?AppColors.mainColor:Colors.white,
                            borderRadius: BorderRadius.circular(Dimensions.radius40),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.textColor,
                                spreadRadius: 1,
                                offset: Offset(0, 0),
                                blurRadius: 2,
                              )
                            ],
                            border: Border.all(
                              color:  AppColors.textColor,
                              width: 1,
                            )
                        ),
                        child: Center(
                          child: BigText(text: listSize[index].toString(),
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.font20,),
                        ),
                      ),
                    ),
                  )),
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: BigText(text: "Color"),
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.width15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: List.generate(listColor.length, (index) =>
                      GestureDetector(
                        onTap: (){
                          shoesController.changeOptionColor(listColor[index]);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: Dimensions.width10),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Color(int.parse(listColor[index])),
                                border: Border.all(
                                  color: listColor[index] == shoesController.optionColor? AppColors.mainColor:Colors.transparent,
                                  width: 5,
                                ),
                                borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                image: DecorationImage(

                                    image: AssetImage("assets/images/a2.png"),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
