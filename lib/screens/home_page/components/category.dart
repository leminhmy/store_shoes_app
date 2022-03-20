import 'package:flutter/material.dart';

import '../../../components/big_text.dart';
import '../../../utils/dimensions.dart';

class Category extends StatelessWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: Dimensions.width20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: "Category",fontWeight: FontWeight.bold,color: Colors.black,fontSize: Dimensions.font26,),
          SizedBox(height: Dimensions.height5,),
          Container(
            height: Dimensions.height50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) => Container(
                  margin: EdgeInsets.only(right: Dimensions.width10),
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width30),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius10)),
                  ),
                  child: Center(child: BigText(text: "All",color: Colors.white,fontSize: Dimensions.font16,fontWeight: FontWeight.bold,)),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
