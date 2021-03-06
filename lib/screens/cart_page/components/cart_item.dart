import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/components/base/show_custom_snackbar.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../controller/cart_controller.dart';
import '../../../models/cart_model.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_contants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key, required this.cartModel, required this.page,
  }) : super(key: key);

  final dynamic cartModel;
  final String page;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Dimensions.height10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //image product
          GestureDetector(
            onTap: (){
              if(page == "cartpage"){
                Get.toNamed(RouteHelper.getShoesDetail(cartModel.product!.id!, "cartpage"));
              }
              if(page == "carthistory"){
                Get.toNamed(RouteHelper.getShoesDetail(cartModel.productId!, "carthistory"));
              }
            },
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius20)),
                child: Image.network(
                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartModel.img!,
                  fit: BoxFit.cover,
                  height: Dimensions.pageViewTextContainer,
                  width: Dimensions.pageViewTextContainer,
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
                  BigText(text: cartModel.name!),
                  SizedBox(height: Dimensions.height5,),
                  Row(
                    children: [
                      SmallText(text: "Color",color: Colors.black,),
                      SizedBox(width: Dimensions.height10,),
                      Icon(Icons.circle,size: Dimensions.iconSize26,color: Color(int.parse(cartModel.color!)),),
                      SizedBox(width: Dimensions.height20,),
                      SmallText(text: "Size: ${cartModel.size.toString()}",color: Colors.black,),
                    ],
                  ),
                  SizedBox(height: Dimensions.height5,),
                  GetBuilder<CartController>(
                      builder: (cartController) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: "\$ ${cartModel.price!}",
                              color: AppColors.redColor,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if(page == "cartpage"){
                                      cartController.addItem(cartModel.product!, -1,color: cartModel.color!,size: cartModel.size!);
                                    }else{
                                      showCustomSnackBar("Th??s is HistoryCart, can't set it");
                                    }
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColors.signColor,
                                  ),
                                ),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                BigText(text: cartModel.quantity!.toString()),
                                SizedBox(
                                  width: Dimensions.width10,
                                ),
                                InkWell(
                                  onTap: () {
                                    if(page == "cartpage"){
                                      cartController.addItem(cartModel.product!, 1,color: cartModel.color!,size: cartModel.size!);
                                    }else{
                                      showCustomSnackBar("Th??s is HistoryCart, can't set it");
                                    }
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.signColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
