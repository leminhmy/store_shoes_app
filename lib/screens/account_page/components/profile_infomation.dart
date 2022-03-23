import 'package:flutter/material.dart';

import '../../../components/icon_and_text_full_contailer.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class ProfileInfomation extends StatelessWidget {
  const ProfileInfomation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            IconAndTextFullContainer(
              colorBackground: AppColors.mainColor,
              iconData: Icons.person,
              text: "User Name",
            ),
            SizedBox(height: Dimensions.height20,),
            IconAndTextFullContainer(
              colorBackground: AppColors.iconColor1,
              iconData: Icons.phone,
              text: "Your phone",
            ),
            SizedBox(height: Dimensions.height20,),
            IconAndTextFullContainer(
              colorBackground: AppColors.iconColor1,
              iconData: Icons.email,
              text: "Your email",
            ),
            SizedBox(height: Dimensions.height20,),
            IconAndTextFullContainer(
              colorBackground: AppColors.iconColor1,
              iconData: Icons.location_on_rounded,
              text: "Fill in the address",
            ),
            SizedBox(height: Dimensions.height20,),
            IconAndTextFullContainer(
              colorBackground: AppColors.redColor,
              iconData: Icons.message,
              text: "message",
            ),
            SizedBox(height: Dimensions.height20,),
            GestureDetector(
              onTap: (){
              },
              child: IconAndTextFullContainer(
                colorBackground: AppColors.redColor,
                iconData: Icons.logout,
                text: "Logout",
              ),
            ),
            SizedBox(height: Dimensions.height20,)
          ],
        ),
      ),
    );
  }
}
