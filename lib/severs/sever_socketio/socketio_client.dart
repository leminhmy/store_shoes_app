import 'dart:convert';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:store_shoes_app/controller/notification_controller.dart';

import '../../controller/messages_controller.dart';
import '../../utils/app_contants.dart';

class SeverSocketIo {

  static IO.Socket socket = IO.io(AppConstants.SOCKETIO_URI,<String, dynamic>{
    "transports":["websocket"],
    "autoConnect":false,
  });


  void connect(dynamic userId){

    socket.connect();
    socket.emit("signin",userId);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {

        if(msg['typeSend'] == "message")
          {
            Get.find<MessagesController>().getMessages();
            Get.find<MessagesController>().getMissMessages();
          }
        if(msg['typeSend'] == "order")
          {
            Get.find<NotificationController>().getNotification();
          }
        print("received data form socketio: "+ jsonEncode(msg));
        // print(msg);
      });

    });
    print(socket.connected);
  }

   void sendData(int id,String typeSend){
     socket.emit("message",{"idTake":id,"typeSend":typeSend});
   }

}