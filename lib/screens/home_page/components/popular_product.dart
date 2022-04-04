import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store_shoes_app/components/base/app_variable.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/models/product.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

import '../../detail_page/detail_page.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key, required this.shoesProduct,
  }) : super(key: key);

  final List<dynamic> shoesProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: Dimensions.width20, left: Dimensions.width20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "Popular",
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: Dimensions.font26,
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          ...List.generate(shoesProduct.length, (index) {
            return GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getShoesDetail(shoesProduct[index].id!, "home"));
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: Dimensions.height20),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20)),
                  child: SizedBox(
                    height: Dimensions.height50*5,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius30),
                              image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+shoesProduct[index].img!),
                                  fit: BoxFit.cover),

                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width20),
                              margin:  EdgeInsets.symmetric(
                                  horizontal: Dimensions.width20,vertical:Dimensions.width10),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius:
                                BorderRadius.circular(Dimensions.radius10),
                              ),
                              height: Dimensions.height50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text: shoesProduct[index].name!,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      SmallText(text: shoesProduct[index].subTitle??"None",color: Colors.white,),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Price: 150.000",style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.red,
                                      ),),
                                      BigText(text: AppVariable().numberFormatPriceVi(shoesProduct[index].price!),color: Colors.red,fontWeight: FontWeight.bold,fontSize: Dimensions.font20,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: Dimensions.height30*2.5,
                              width: Dimensions.width50,
                              decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  image: DecorationImage(
                                      image: AssetImage("assets/images/sellera.png"),
                                      fit: BoxFit.cover
                                  )
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SmallText(text: "SELL",color: Colors.amberAccent,),
                                    BigText(text: "33%",color: Colors.white,fontWeight: FontWeight.bold,),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );

          })
        ],
      ),
    );
  }
}
