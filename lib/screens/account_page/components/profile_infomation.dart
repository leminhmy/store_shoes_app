import 'package:flutter/material.dart';


import '../../../components/icon_and_text_full_contailer.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import 'package:get/get.dart';

class ProfileInfomation extends StatelessWidget {
  const ProfileInfomation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                IconAndTextFullContainer(
                  colorBackground: AppColors.mainColor,
                  iconData: Icons.person,
                  text: userController.userModel!.name,
                ),
                SizedBox(height: Dimensions.height20,),
                IconAndTextFullContainer(
                  colorBackground: AppColors.iconColor1,
                  iconData: Icons.phone,
                  text: userController.userModel!.phone,
                ),
                SizedBox(height: Dimensions.height20,),
                IconAndTextFullContainer(
                  colorBackground: AppColors.iconColor1,
                  iconData: Icons.email,
                  text: userController.userModel!.email,
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
                    if(Get.find<AuthController>().userLoggedIn()){
                      Get.find<AuthController>().clearSharedData();
                      Get.find<CartController>().clear();
                      Get.find<CartController>().clearCartHistory();
                      Get.offNamed(RouteHelper.getSignInPage());
                    }
                    else{
                      print("you logged out");
                    }
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
    );
  }
}
