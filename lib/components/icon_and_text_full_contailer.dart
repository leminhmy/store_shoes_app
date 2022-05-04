import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'icon_background_border_radius.dart';

class IconAndTextFullContainer extends StatelessWidget {
  const IconAndTextFullContainer({
    Key? key, required this.iconData, required this.text, required this.colorBackground, this.colorIcon = Colors.white,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final Color colorBackground;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimensions.height5,horizontal: Dimensions.height5),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconBackgroundBorderRadius(
              backgroundColor: colorBackground,
              sizeHeight: Dimensions.height30*2,
              iconColor: colorIcon,
              size: Dimensions.iconSize26,
              icon: iconData,
              press: () {}),
          SizedBox(width: Dimensions.width10,),
          SmallText(text: text,color: Colors.black,fontSize: Dimensions.font18),
        ],
      ),
    );
  }
}