import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/auth/sign_in_page.dart';
import 'package:store_shoes_app/screens/cart_page/cart_page.dart';
import 'package:store_shoes_app/screens/detail_page/detail_page.dart';
import 'package:store_shoes_app/screens/home_page/components/home_page.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/screens/home_page/main_home_page.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<ShoesController>().getShoesTypeList();
    return GetBuilder<LeatherProductController>(
      builder: (_) {
        Get.find<LeatherProductController>().getLeatherProductList();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: const MainHomePage(),
          initialRoute: RouteHelper.getInitial(),
          getPages: RouteHelper.routes,
        );
      }
    );
  }
}

