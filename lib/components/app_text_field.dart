import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {
   AppTextField({
    Key? key,
    required this.textFieldController, required this.prefixIcon, this.colorIcon = Colors.grey, required this.hintText, this.isObscure = false,
  }) : super(key: key);

  final TextEditingController textFieldController;
  final IconData prefixIcon;
  final Color colorIcon;
  final String hintText;
  bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                offset: Offset(1, 5),
                color: Colors.grey.withOpacity(0.2),
              ),
            ]
        ),
        child: TextField(

          obscureText: isObscure?true:false,
          controller: textFieldController,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(prefixIcon,color: colorIcon,),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
              )
          ),
        )
    );
  }
}
