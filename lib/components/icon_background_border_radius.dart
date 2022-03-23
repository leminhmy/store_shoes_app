import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class IconBackgroundBorderRadius extends StatelessWidget {
  IconBackgroundBorderRadius({
    Key? key,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.size = 18,
    required this.press, this.iconColor = Colors.black, this.sizeHeight = 50,
  }) : super(key: key);

  final IconData icon;
  final Color backgroundColor;
  final double size;
  final VoidCallback press;
  final Color iconColor;
  final double sizeHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20)),
      onTap: press,
      child: SizedBox(
        height: sizeHeight==50?Dimensions.height50:sizeHeight,
        width: sizeHeight==50?Dimensions.height50:sizeHeight,
        child: CircleAvatar(
          backgroundColor: backgroundColor == Colors.white
              ? AppColors.buttonBackgroundColor
              : backgroundColor,
          child: Icon(
            icon,
            size: size == 18 ? Dimensions.iconSize24 : size,
            color: iconColor==Colors.black?AppColors.signColor:iconColor,
          ),
        ),
      ),
    );
  }
}