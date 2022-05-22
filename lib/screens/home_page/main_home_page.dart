import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/user_controller.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/account_page/account_page.dart';
import 'package:store_shoes_app/screens/auth/sign_in_page.dart';
import 'package:store_shoes_app/screens/auth/sign_up_page.dart';
import 'package:store_shoes_app/screens/cart_history_page/cart_history_page.dart';

import 'package:store_shoes_app/screens/home_page/components/home_page.dart';
import 'package:store_shoes_app/screens/messaging_page/messaging_page.dart';
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
    MessagingPage(),
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
    Get.find<ShoesController>().getShoesProductList();
    Get.find<ShoesController>().getShoesTypeList();

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),

            label: "home",

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger),
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
