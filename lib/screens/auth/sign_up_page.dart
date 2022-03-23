import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../../components/app_text_field.dart';
import 'package:get/get.dart';

import '../../components/big_text.dart';
import '../../components/button_border_radius.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var singUpImage = [
      "t.png",
      "f.png",
      "g.png",
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
              height: Dimensions.screenHeight * 0.25,
              child: Center(
                child: Container(
                  height: 200,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      image: DecorationImage(
                        image: AssetImage("assets/images/a2.png"),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
              ),
            ),
            //body signUp infomation
            Column(
              children: [
                AppTextField(
                  textFieldController: emailController,
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  colorIcon: AppColors.mainColor,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  isObscure: true,
                  textFieldController: passwordController,
                  hintText: "Password",
                  prefixIcon: Icons.password_sharp,
                  colorIcon: AppColors.mainColor,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  textFieldController: phoneController,
                  hintText: "Phone",
                  prefixIcon: Icons.phone_android_outlined,
                  colorIcon: AppColors.mainColor,
                ),
                SizedBox(
                  height: Dimensions.height20,
                ),
                AppTextField(
                  textFieldController: nameController,
                  hintText: "Name",
                  prefixIcon: Icons.person,
                ),
              ],
            ),
            //Sign up and Sign in other ways
            Column(
              children: [
                SizedBox(
                  height: Dimensions.height30,
                ),
                GestureDetector(
                  onTap: () {
                  },
                  child: ButtonBorderRadius(
                    widget: Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      child: BigText(
                          text: "Sign Up",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.font26),
                    ),
                    colorBackground: AppColors.mainColor,
                    borderRadius: Dimensions.radius20 * 1.3,
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10,
                ),
                RichText(
                    text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ))),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                RichText(
                    text: TextSpan(
                        text: "Sign up using one of the following methos",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16,
                        ))),
                Wrap(
                  children: List.generate(
                      singUpImage.length,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                              "assets/images/" + singUpImage[index]),
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
