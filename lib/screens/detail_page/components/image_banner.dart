import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/border_radius_widget.dart';
import 'package:store_shoes_app/screens/home_page/main_home_page.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class ImageBanner extends StatelessWidget {
  const ImageBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height50*7.8,
      child: Align(
        alignment: Alignment.topCenter,
        child: Stack(
          children: [
            SizedBox(
              height: Dimensions.height50*7,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.only(right: Dimensions.width5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.radius40*3)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/a2.png"),
                        fit: BoxFit.contain,

                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 10),
                          spreadRadius: -3,
                          blurRadius: 15,
                        )
                      ]
                  ),
                );
              }),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(right: Dimensions.width20),
                child: CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: AppColors.redColor,
                  child: Center(
                    child: Icon(Icons.favorite_outlined,color: Colors.white,size: Dimensions.iconSize26*2,),
                  ),

                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                padding: EdgeInsets.symmetric(vertical: Dimensions.height5,horizontal: Dimensions.width15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  )
                ),
                child: BigText(text: "Page: 1/5",fontWeight: FontWeight.bold,),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.height20,horizontal: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> MainHomePage());
                      },
                        child: BorderRadiusWidget(widget: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,))),
                    BorderRadiusWidget(widget: Icon(Icons.shopping_cart_outlined,color: Colors.white,)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
