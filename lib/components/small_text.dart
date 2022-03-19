import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    Key? key, required this.text, this.fontSize = 12, this.color = Colors.grey,
  }) : super(key: key);

  final String text;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      color: color==Colors.grey?AppColors.textColor:color,
      fontSize: fontSize==12?Dimensions.font12:fontSize,
    ));
  }
}