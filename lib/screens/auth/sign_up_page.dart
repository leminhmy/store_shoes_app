import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


import '../../components/app_text_field.dart';
import 'package:get/get.dart';

import '../../components/base/show_custom_snackbar.dart';
import '../../components/big_text.dart';
import '../../components/button_border_radius.dart';
import '../../controller/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var singUpImage = [
    "t.png",
    "f.png",
    "g.png",
  ];

  //showpassword
  bool isShowVisibility = false;

  //token_messgaes
  String deviceTokenToSendPushNotification = "";


  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceTokenToSendNotification();
  }

  @override
  Widget build(BuildContext context) {
    late BuildContext dialogContext;

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six character",
            title: "Password");
      } else {

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              dialogContext = context;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  BigText(text: "Đang login"),
                ],
              );
            });
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password,tokenMessages: deviceTokenToSendPushNotification);
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Navigator.pop(dialogContext);
            print("Success registration");
            Get.offNamed(RouteHelper.getInitial());
          }else{
            Navigator.pop(dialogContext);
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return SingleChildScrollView(
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
                      suffixIcon:IconButton(
                        onPressed: (){
                          setState(() {
                            isShowVisibility =!isShowVisibility;

                          });
                        },
                        icon: isShowVisibility?const Icon(Icons.visibility_off):const Icon(Icons.visibility),
                      ),
                      isObscure: isShowVisibility,
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
                        _registration(_authController);
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
          );
        }
      ),
    );
  }
}
