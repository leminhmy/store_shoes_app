import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ScreenTest extends StatefulWidget {
  const ScreenTest({Key? key}) : super(key: key);

  @override
  State<ScreenTest> createState() => _ScreenTestState();
}

class _ScreenTestState extends State<ScreenTest> {

  late TextEditingController _usernameControlller;
  late IO.Socket socket;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
    _usernameControlller = TextEditingController();

  }

  void connect(){
    socket = IO.io("https://easy-realtime-demo.herokuapp.com/",<String, dynamic>{
      "transports":["websocket"],
      "autoConnect":false,
    });
    socket.connect();
    socket.emit("signin",10);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print("get data");
        // print(msg);
      });
    });
    print(socket.connected);
  }

  void sendData(int id){
    socket.emit("message",{"idTake":id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's RealTime  Test"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _usernameControlller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 20,),
            TextButton(onPressed: (){
              connect();//
            }, child: Text("LOGIN"),),
            TextButton(onPressed: (){
              sendData(12);
            }, child: Text("SendData"),)
          ],
        ),
      ),
    );
  }
}
