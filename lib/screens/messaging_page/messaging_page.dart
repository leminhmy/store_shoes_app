import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_shoes_app/components/big_text.dart';
import 'package:store_shoes_app/components/small_text.dart';
import 'package:store_shoes_app/controller/messages_controller.dart';
import 'package:store_shoes_app/models/messages.dart';
import 'package:store_shoes_app/models/user_model.dart';
import 'package:store_shoes_app/severs/sever_socketio/socketio_client.dart';
import 'package:store_shoes_app/utils/colors.dart';
import 'package:store_shoes_app/utils/dimensions.dart';

import '../../components/base/show_custom_snackbar.dart';
import '../../controller/auth_controller.dart';
import '../../controller/user_controller.dart';
import '../../data/api/api_client.dart';
import '../../utils/app_contants.dart';
import '../cart_history_page/cart_history_page.dart';
import 'components/messaging_cart.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key, required this.userTake, required this.userModel}) : super(key: key);

  final int userTake;
  final UserModel userModel;

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  List<MessagesModel> listMessages = [];
  int? userId;
  int? userTake;
  String messaging = "";
  TextEditingController typeMessaging = TextEditingController();

  //image
  final ImagePicker _picker = ImagePicker();
  XFile? fileImage;
  XFile? fileImageSend;

  //status
  int statusSend = 0;
  late BuildContext dialogContext;

  //socketio
  late final IO.Socket socket;

  @override
  void initState() {
    // TODO: implement initState
    socket = IO.io(AppConstants.SOCKETIO_URI,<String, dynamic>{
      "transports":["websocket"],
      "autoConnect":false,
    });
    super.initState();

    fileImageSend = null;
    fileImage = null;
    userTake = widget.userTake;
    if (Get.find<AuthController>().userLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      Get.find<MessagesController>().setSeeMessages(userTake.toString());
      Get.find<MessagesController>().getMissMessages();
      userId = Get.find<UserController>().userModel!.id!;
      Get.find<MessagesController>().getMessages();
      SeverSocketIo().connect(userId);
    }
  }

  void imageSelect() async {
    fileImage = null;
    fileImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  void sendMessaging(BuildContext context) async {
    statusSend = 1;
    fileImageSend = fileImage;
    messaging = typeMessaging.value.text;

    if (typeMessaging.value.text == "" && fileImage == null) {
      showCustomSnackBar("Messaging is Empty", title: "Error send Messaging");
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
                BigText(text: "messaging..."),
              ],
            );
          });
      var postUri =
          Uri.parse(AppConstants.BASE_URL + AppConstants.MESSAGES_SEND_URI);
      http.MultipartRequest request = http.MultipartRequest(
        "POST",
        postUri,
      );
      //check image;
      if (fileImage != null) {
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'image', fileImage!.path,
            filename: basename(fileImage!.path));
        request.files.add(multipartFile);
      }
      ApiClient apiClient = ApiClient(
          appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find());
      request.headers.addAll(apiClient.getMainHeader());
      request.fields['id_take'] = userTake.toString();
      if (typeMessaging.value.text != "") {
        request.fields['messaging'] = typeMessaging.value.text;
      }
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        SeverSocketIo().sendData(userTake!, "message");
        // sendData(userTake!);
        Get.find<MessagesController>().sendNotification(typeNotification: "messaging",title: "Messages",content: messaging, userId: widget.userModel.id!);
        Navigator.pop(dialogContext);
        fileImage = null;
        fileImageSend = null;
        messaging = "";
        statusSend = 2;
        typeMessaging = TextEditingController(text: "");
        Get.find<MessagesController>().getMessages();
        setState(() {});
      } else {
        Navigator.pop(dialogContext);
        showCustomSnackBar("Error send messages", title: "Error");
        statusSend = 3;
        setState(() {});
      }
      print(response.statusCode);
    }
  }

  //realtime with socketio sever web haruko


  // void sendData(int id){
  //   socket.emit("message",{"idTake":id});
  // }

  // void connect(dynamic userId){
  //
  //   socket.connect();
  //   socket.emit("signin",userId);
  //   socket.onConnect((data) {
  //     print("Connected");
  //     socket.on("message", (msg) {
  //       Get.find<MessagesController>().getMessages();
  //       Get.find<MessagesController>().getMissMessages();
  //
  //       // print(msg);
  //     });
  //   });
  //   print(socket.connected);
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: GetBuilder<MessagesController>(
        builder: (messageController) {
          if (Get.find<AuthController>().userLoggedIn()) {
            listMessages = messageController.getMessagesPeople(userTake!);
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        //get api
                        ...List.generate(listMessages.length, (index) => MessagesCart(messagesModel: listMessages[index], userId: userId!,)),


                        //local send
                        Padding(
                          padding: EdgeInsets.only(right: Dimensions.height10,bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              messaging!= ""?Container(
                                  margin: EdgeInsets.only(top: Dimensions.height10),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.height20,
                                      vertical: Dimensions.height10
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(Dimensions.radius20 / 1.5),
                                  ),
                                  child: BigText(text: messaging,color: Colors.black,)):Container(),
                              SizedBox(height: Dimensions.height10,),
                              fileImageSend != null?Container(
                                height: Dimensions.height50*3,
                                width: Dimensions.height50*3,
                                decoration: BoxDecoration(
                                  color: AppColors.greenColor,
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                                  image: DecorationImage(
                                      image: FileImage(
                                        File(fileImageSend!.path),
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ):Container(),
                              statusSend != 0?Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  color: AppColors.textColor,
                                ),
                                child:
                                statusSend ==1 ?Icon(Icons.upgrade_outlined,color:Colors.yellow,size: Dimensions.iconSize18,):
                                statusSend ==2?Icon(Icons.done_outlined,color:AppColors.mainColor,size: Dimensions.iconSize18,):Icon(Icons.close,color:Colors.red,size: Dimensions.iconSize18,),
                              ):Container(),
                              statusSend == 3?InkWell(
                                onTap: (){
                                  sendMessaging(context);
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.height10,
                                        vertical: Dimensions.height5
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.btnClickColor,
                                      borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                    ),
                                    child: Column(
                                      children: [
                                        SmallText(text: "Replay",color: Colors.red,),
                                      ],
                                    )),
                              ):Container(),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )),
              buildBottomNavigator(context),
            ],
          );
        }
      ),
    );
  }

  buildBottomNavigator(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: Dimensions.height50 * 1.5,
          padding: EdgeInsets.only(left: Dimensions.height10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  color: Colors.grey,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.mic,
                color: AppColors.mainColor,
                size: Dimensions.iconSize26,
              ),
              SizedBox(
                width: Dimensions.height5,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height10,
                    vertical: Dimensions.height5),
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(Dimensions.radius40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt_outlined),
                    SizedBox(
                      width: Dimensions.height10,
                    ),
                    Expanded(
                        child: TextField(
                      controller: typeMessaging,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: "Type message", border: InputBorder.none),
                    )),
                    IconButton(
                        onPressed: () {
                          imageSelect();
                        },
                        icon: Icon(Icons.image_outlined)),
                    SizedBox(
                      width: Dimensions.height10,
                    ),
                    Icon(Icons.camera_alt_outlined),
                  ],
                ),
              )),
              IconButton(
                  highlightColor: Colors.red,
                  onPressed: () {
                    sendMessaging(context);
                    print("taped");
                  },
                  icon: Icon(
                    Icons.send,
                    color: AppColors.mainColor,
                    size: Dimensions.iconSize26 * 1.4,
                  ))
            ],
          ),
        ),
        fileImage != null
            ? Positioned(
                left: Dimensions.height5,
                bottom: Dimensions.height50 * 1.7,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: Dimensions.height50 * 3,
                      width: Dimensions.height50 * 3,
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10),
                        image: DecorationImage(
                            image: FileImage(
                              File(fileImage!.path),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              )
            : Positioned(bottom: 0, right: 0, child: Container()),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.btnClickColor,
      title: Row(
        children: [
          widget.userModel.image == ""?const CircleAvatar(
            backgroundImage: AssetImage("assets/images/a1.jpg"),
          ):CircleAvatar(
            backgroundColor: AppColors.mainColor,
            backgroundImage: NetworkImage(AppConstants.BASE_URL +
                AppConstants.UPLOAD_URL +"users/"+
                widget.userModel.image!)
          ),
          SizedBox(
            width: Dimensions.height10,
          ),
          BigText(text: widget.userModel.name!),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.local_phone)),
        IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.videocam)),
      ],
    );
  }
}
