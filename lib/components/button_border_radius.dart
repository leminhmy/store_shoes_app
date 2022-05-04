import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ButtonBorderRadius extends StatelessWidget {
  ButtonBorderRadius({
    Key? key, required this.widget, this.colorBackground = Colors.white, this.borderRadius = 30,
  }) : super(key: key);

  final Widget widget;
  final Color colorBackground;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(Dimensions.width15),
        decoration: BoxDecoration(
          color: colorBackground==Colors.white?Colors.white:colorBackground,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius==30?Dimensions.radius20:borderRadius)),
        ),
        child: widget
    );
  }
}