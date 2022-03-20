import 'package:flutter/material.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

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
          ...List.generate(5, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: Dimensions.height20),
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20)),
                child: Container(
                  color: Colors.green,
                  height: Dimensions.height50*5,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius10),
                              image: DecorationImage(
                                  image: AssetImage("assets/images/a2.jpg"),
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
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                        text: "Nike AdaptBB",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    SmallText(text: "Man running Shoes",color: Colors.white,),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Price: 150.000",style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                    ),),
                                    BigText(text: "Price: 150.000",color: Colors.red,fontWeight: FontWeight.bold,fontSize: Dimensions.font20,),
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
            );

          })
        ],
      ),
    );
  }
}
