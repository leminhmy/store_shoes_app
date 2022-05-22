import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/controller/map_controller.dart';
import 'package:store_shoes_app/controller/messages_controller.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/notificationservice/local_notification_service.dart';
import 'package:store_shoes_app/routes/route_helper.dart';
import 'package:store_shoes_app/screens/auth/sign_in_page.dart';
import 'package:store_shoes_app/screens/cart_page/cart_page.dart';
import 'package:store_shoes_app/screens/detail_page/detail_page.dart';
import 'package:store_shoes_app/screens/home_page/components/home_page.dart';
import 'package:get/get.dart';
import 'package:store_shoes_app/screens/home_page/main_home_page.dart';
import 'package:store_shoes_app/screens/search_page/search_page.dart';
import 'package:store_shoes_app/screens/test_screen/test_function_socketio.dart';
import 'controller/cart_controller.dart';
import 'controller/user_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  // print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      // LocalNotificationService.createanddisplaynotification(message);
    }
  });
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    Get.find<ShoesController>().getShoesTypeList();
    Get.find<CartController>().getCartData();
    Get.find<MapController>().getMapProvine();
    if(Get.find<AuthController>().userLoggedIn()){
      Get.find<UserController>().getUserInfo();
      Get.find<MessagesController>().getMessages();
    }
    return GetBuilder<OrderController>(
      builder: (_) {
        return GetBuilder<MessagesController>(
          builder: (_) {
            return GetBuilder<LeatherProductController>(
                builder: (_) {
                  Get.find<LeatherProductController>().getLeatherProductList();
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    // home: const ScreenTest(),
                    initialRoute: RouteHelper.getInitial(),
                    getPages: RouteHelper.routes,
                  );
                }
            );
          }
        );
      }
    );
  }
}

