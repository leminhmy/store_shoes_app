import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key? key, required this.text, this.fontSize = 18, this.color = Colors.grey, this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      color: color==Colors.grey?AppColors.mainColor:color,
      fontSize: fontSize==18?Dimensions.font18:fontSize,
      fontWeight: FontWeight.w500,
    ));
  }
}