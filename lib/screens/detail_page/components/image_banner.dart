import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

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
            Container(
              height: Dimensions.height50*7,
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
            )
          ],
        ),
      ),
    );
  }
}
