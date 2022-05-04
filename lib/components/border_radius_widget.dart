import 'package:flutter/material.dart';
import 'package:store_shoes_app/utils/colors.dart';

import '../utils/dimensions.dart';

class BorderRadiusWidget extends StatelessWidget {
  const BorderRadiusWidget({
    Key? key, this.size = 40, this.colorBackground = Colors.white, required this.widget, this.radius = 30,
  }) : super(key: key);

  final double size;
  final Color colorBackground;
  final Widget widget;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size==40?Dimensions.height40:size,
      width: size==40?Dimensions.width40:size,
      decoration: BoxDecoration(
          color: colorBackground==Colors.white?AppColors.mainColor:colorBackground,
          borderRadius: BorderRadius.circular(radius==30?Dimensions.radius30:radius)
      ),
      child: Center(child: widget)
    );
  }
}
