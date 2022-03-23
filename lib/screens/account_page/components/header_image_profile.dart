import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class HeaderImageProfile extends StatelessWidget {
  const HeaderImageProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Dimensions.height50*4,
        padding: EdgeInsets.all(Dimensions.height10),
        width: double.maxFinite,
        child: Center(
          child: CircleAvatar(
            maxRadius: double.maxFinite,
            backgroundColor: AppColors.mainColor,
            child: Icon(
              Icons.person,
              size: Dimensions.iconSize26 * 4,
              color: Colors.white,
            ),
          ),
        ));
  }
}
