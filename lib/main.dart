
import 'package:flutter/material.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/leather_product_controller.dart';
import 'package:store_shoes_app/controller/map_controller.dart';
import 'package:store_shoes_app/controller/messages_controller.dart';
import 'package:store_shoes_app/controller/notification_controller.dart';
import 'package:store_shoes_app/controller/order_controller.dart';
import 'package:store_shoes_app/controller/shoes_controller.dart';
import 'package:store_shoes_app/notificationservice/local_notification_service.dart';
import 'package:store_shoes_app/routes/route_helper.dart';

import 'package:get/get.dart';
import 'package:store_shoes_app/severs/sever_socketio/socketio_client.dart';

import 'controller/cart_controller.dart';
import 'controller/user_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    //
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      LocalNotificationService.createanddisplaynotification(message);
    }
  });

  //firebase notification
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //getdata


  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    Get.find<ShoesController>().getShoesProductList();
    Get.find<ShoesController>().getShoesTypeList();
    Get.find<CartController>().getCartData();
    Get.find<MapController>().getMapProvine();

    return GetBuilder<MapController>(
      builder: (_) {
        return GetBuilder<NotificationController>(
          builder: (_) {
            return GetBuilder<CartController>(
              builder: (_) {
                return GetBuilder<ShoesController>(
                  builder: (_) {
                    return GetBuilder<UserController>(
                        builder: (_) {

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
                    );
                  }
                );
              }
            );
          }
        );
      }
    );
  }
}

