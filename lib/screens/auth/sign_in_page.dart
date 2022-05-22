import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/controller/user_controller.dart';

import 'package:store_shoes_app/screens/auth/sign_up_page.dart';

import '../../components/app_text_field.dart';
import '../../components/base/show_custom_snackbar.dart';
import '../../components/big_text.dart';
import '../../components/button_border_radius.dart';
import '../../controller/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
   bool isShowVisibility = false;
   var emailController = TextEditingController();
   var passwordController = TextEditingController();
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
    Future<void> _login(AuthController authController) async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();


      if (email.isEmpty) {
        showCustomSnackBar("Email Rỗng",
            title: "Error Email");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Email không đúng định dạng",
            title: "Error Valid Email");
      } else if (password.isEmpty) {
        showCustomSnackBar("Password Rỗng", title: "Error Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password tối thiểu 6 kí tự",
            title: "Error Valid Passoword ");
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
       await authController.login(email, password).then((status){
          if(status.isSuccess){
            Navigator.pop(dialogContext);
            Get.toNamed(RouteHelper.getInitial());
            Get.find<OrderController>().getOrderList();
            Get.find<UserController>().getUserInfo();
            print("Login success");
          }else{
            Navigator.pop(dialogContext);
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimensions.height20),
                  height: Dimensions.screenHeight * 0.25,
                  child: Center(
                    child: Container(
                      height: Dimensions.height50*4,
                      width: Dimensions.height50*5,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Hello",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.font26 * 2.5,
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Sign into your account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
                //input signIn
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      suffixIcon: IconButton(
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
                      prefixIcon: Icons.password,
                      colorIcon: AppColors.mainColor,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Dimensions.width20),
                      child: RichText(
                          text: TextSpan(
                              text: "Sign into your account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ))),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.screenHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: ()async{

                           await _login(authController);
                          },
                          child: ButtonBorderRadius(
                            widget: Container(
                              margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                              child: BigText(
                                  text: "Sign In",
                                  color: Colors.white,
                                  fontSize: Dimensions.font26),
                            ),
                            colorBackground: AppColors.mainColor,
                            borderRadius: Dimensions.radius20 * 1.3,
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Don't have an ccount?",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                                  text: "Create",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.font20,
                                      fontWeight: FontWeight.bold
                                  ),
                                )
                              ]
                          ),

                        ),

                      ],
                    ),


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
