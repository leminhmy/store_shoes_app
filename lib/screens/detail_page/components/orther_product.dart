import 'package:flutter/material.dart';
import 'package:store_shoes_app/models/product.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class OrtherProduct extends StatelessWidget {
  const OrtherProduct({
    Key? key, required this.listOtherProduct,
  }) : super(key: key);

  final List<ProductsModel> listOtherProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Dimensions.width20),
          child: BigText(text: "Other Product",fontWeight: FontWeight.bold,fontSize: Dimensions.font26,),
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.width15,bottom: Dimensions.height20),
            child: Row(
              children: List.generate(listOtherProduct.length > 8?8:listOtherProduct.length, (index) =>
                  Container(
                    width: Dimensions.height50*3,
                    height: Dimensions.height50*4,
                    padding: EdgeInsets.only(right: Dimensions.width10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL+ listOtherProduct[index].img!),
                                  fit: BoxFit.cover,
                                ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height50*2,
                          child: Column(
                            children: [
                              Text(listOtherProduct[index].name!,overflow: TextOverflow.clip,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.font20,
                              ),),
                              BigText(text: listOtherProduct[index].price!.toString(),fontSize: Dimensions.font20,),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
