import 'package:flutter/material.dart';


import '../../components/big_text.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'components/header_image_profile.dart';
import 'components/profile_infomation.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: Dimensions.height50 * 1.5,
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: BigText(text: "Profile",color: Colors.white,fontWeight: FontWeight.bold,fontSize: Dimensions.font26),
      ),
      body: Column(
        children: [
          HeaderImageProfile(),
          ProfileInfomation(),
        ],
      )
    );
  }
}


