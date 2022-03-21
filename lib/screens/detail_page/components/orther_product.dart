import 'package:flutter/material.dart';

import '../../../components/big_text.dart';
import '../../../components/small_text.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class OrtherProduct extends StatelessWidget {
  const OrtherProduct({
    Key? key,
  }) : super(key: key);

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
              children: List.generate(8, (index) =>
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width10),
                    child: SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 100,
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppColors.redColor,
                                borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/a2.png"),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                          Column(
                            children: [
                              Text("Nike shoes Product Product",overflow: TextOverflow.clip,maxLines: 2,textAlign: TextAlign.center,style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.font20,
                              ),),
                              BigText(text: "199.999đ",fontSize: Dimensions.font20,),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
