import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';


class EditTextForm extends StatelessWidget {
  const EditTextForm({
    Key? key, this.minLines = 1, required this.labelText, this.hintText = "HintText", this.fillColor = Colors.white, this.radiusBorder = 10, required this.controller, this.textInputType=TextInputType.multiline,
  }) : super(key: key);

  final int minLines;
  final String labelText;
  final String hintText;
  final Color fillColor;
  final double radiusBorder;
  final TextEditingController controller;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

        controller: controller,
        minLines: minLines, // any number you need (It works as the rows for the textarea)
        keyboardType: textInputType,
        maxLines: null,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            fontSize: Dimensions.font22,
                fontWeight: FontWeight.bold,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          fillColor: fillColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder==10?Dimensions.radius10:radiusBorder),
            borderSide: BorderSide(
              color: AppColors.mainColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusBorder==10?Dimensions.radius10:radiusBorder),
            borderSide: BorderSide(
              color:AppColors.paraColor,
              width: 3,
            ),
          ),
        )
    );
  }
}
