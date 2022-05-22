import 'package:flutter/material.dart';

import '../../components/base/custom_loader.dart';
import '../../components/big_text.dart';
import '../../controller/auth_controller.dart';
import '../../controller/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'components/header_image_profile.dart';
import 'components/profile_infomation.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("User has logged : ");
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: Dimensions.height50 * 1.5,
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(text: "Profile",color: Colors.white,fontWeight: FontWeight.bold,fontSize: Dimensions.font26),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn?(userController.isLoading?
          Column(
            children: [
              HeaderImageProfile(),
              ProfileInfomation(),
            ],
          ):CustomLoader()):
          Container(child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: Dimensions.height20*9,
                  margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/signintocontinue.png"),
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  child: Container(
                    width: double.maxFinite,
                    height: Dimensions.height20*5,
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child: Center(child: BigText(text: "Sign in",color: Colors.white,fontSize: Dimensions.font26,)),
                  ),
                ),

              ],
            ),
          ),);
        }
      ),
    );
  }
}


