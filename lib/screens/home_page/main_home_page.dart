import 'package:flutter/material.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/user_controller.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/account_page/account_page.dart';
import 'package:store_shoes_app/screens/auth/sign_in_page.dart';
import 'package:store_shoes_app/screens/auth/sign_up_page.dart';
import 'package:store_shoes_app/screens/cart_history_page/cart_history_page.dart';

import 'package:store_shoes_app/screens/home_page/components/home_page.dart';
import 'package:store_shoes_app/screens/messaging_page/messages_page.dart';
import 'package:store_shoes_app/screens/messaging_page/messaging_page.dart';
import 'package:store_shoes_app/severs/sever_socketio/socketio_client.dart';
import 'package:store_shoes_app/utils/app_contants.dart';
import 'package:store_shoes_app/utils/dimensions.dart';
import '../../controller/cart_controller.dart';
import '../../controller/map_controller.dart';
import '../../controller/messages_controller.dart';
import '../../controller/shoes_controller.dart';
import '../../utils/colors.dart';
import 'package:get/get.dart';


class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedIndex = 0;

  List page = [
    HomePage(),
    MessagesPage(),
    CartHistoryPage(),
    AccountPage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(Get.find<AuthController>().userLoggedIn()){

      Get.find<UserController>().getUserInfo().then((status) {
        if(status.isSuccess){
          Get.find<UserController>().getUserInfo();

          Get.find<MessagesController>().getMessages();

        }
      });

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "home",

          ),
          BottomNavigationBarItem(
            icon: GetBuilder<AuthController>(
              builder: (authController) {

                return GetBuilder<MessagesController>(
                  builder: (messagesController) {
                    // connect(userId);
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(Icons.messenger),
                        messagesController.listMissMessages.isNotEmpty?Positioned(
                          right: -Dimensions.height10,
                          top: -Dimensions.height10,
                          child: CircleAvatar(
                            maxRadius: Dimensions.height10,
                            backgroundColor: Colors.red,
                            child: SmallText(text: messagesController.listMissMessages.length.toString(),color: Colors.white),
                          ),
                        ):Positioned(
                          right: 0,
                            top: 0,
                            child: Container()),
                      ],
                    );
                  }
                );
              }
            ),
            label: "mess",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "cart history",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "me",
          ),
        ],
      ),
    );
  }


}
