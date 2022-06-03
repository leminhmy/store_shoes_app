import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/user_controller.dart';
import 'package:store_shoes_app/data/repository/messages_repo.dart';
import 'package:store_shoes_app/models/messages.dart';
import 'package:store_shoes_app/models/notification_model.dart';
import 'package:store_shoes_app/models/user_model.dart';

import '../models/responseModel.dart';
import '../utils/app_contants.dart';
import 'package:http/http.dart' as http;

class MessagesController extends GetxController{
  final MessagesRepo messagesRepo;
  
  MessagesController({required this.messagesRepo});

  
  List<MessagesModel> _listMessages = [];
  List<MessagesModel> get listMessages => _listMessages;

  List<MessagesModel> _listMissMessages = [];
  List<MessagesModel> get listMissMessages => _listMissMessages;





  Future<ResponseModel> getMessages() async {

    Response response = await messagesRepo.getMessages();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {

      _listMessages = [];
      response.body.forEach((v) {
        _listMessages.add(MessagesModel.fromJson(v));
      });
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    print("get messages");
    // var testList = [];
    // _listMessages.forEach((element) {
    //   testList.add(jsonEncode(element));
    // }
    // );
    // print(testList);
    return responseModel;
  }
  Future<ResponseModel> getMissMessages() async {

    Response response = await messagesRepo.getMissMessages();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {

      _listMissMessages = [];
      response.body.forEach((v) {
        _listMissMessages.add(MessagesModel.fromJson(v));
      });
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();

    print("get miss messages");
    /*var testList = [];
    _listMissMessages.forEach((element) {
      testList.add(jsonEncode(element));
    }
    );
    print(testList);*/
    return responseModel;
  }

  Future<ResponseModel> setSeeMessages(String userIdTake) async {

    Response response = await messagesRepo.setSeeMessages(userIdTake);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  getMessagesPeople(int idPeople){
    List<MessagesModel> listMessagesPeople = [];
    if(Get.find<AuthController>().userLoggedIn()){
      int userId = Get.find<UserController>().userModel!.id!;
      _listMessages.forEach((element) {
        if(element.idSend == userId && element.idTake == idPeople || element.idSend == idPeople && element.idTake == userId){
          listMessagesPeople.add(element);
        }
      });
    }
    else{
      print("user chua login");
    }


    return listMessagesPeople;

  }

  MessagesModel getLastMessPeople(int idPeople){
    late MessagesModel messagesModel;
    int userId = Get.find<UserController>().userModel!.id!;

      _listMessages.forEach((element) {
        if(element.idSend == userId && element.idTake == idPeople || element.idSend == idPeople && element.idTake == userId){
              messagesModel = element;
        }
      });

    return messagesModel;
  }

  int getMissMessaging(int idPeople){
    int value = 0;
     _listMissMessages.forEach((element) {
      if(element.idSend == idPeople){
        value++;
      }
    });
    return value;
  }


  Future<http.Response> sendNotification({required String typeNotification,required String title, required String content, required int userId}) async {
    //save notification
    if(typeNotification == "order"){
      Map saveBody = {
        "user_idsend": userId,
        "title": title,
        "body": content
      };
      Response responseGetx = await messagesRepo.saveNotification(saveBody);
      if(responseGetx.statusCode == 200)
      {
        print("save notification success");
      }
      else{
        print("save notification error");
      }
    }

    //send notification fcm
    List<UserModel> listUser = [];
    listUser = Get.find<UserController>().listUsers;
    UserModel? userModel;
    listUser.forEach((element) {
      if(element.id == userId){
        userModel = element;
      }
    });


    var postUri =
    Uri.parse(AppConstants.MESSAGES_SEND_NOTIFICATION_FCM);
    //header
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'key=AAAAJuMHBZc:APA91bHvuk9es6StPAAfjVyEyYmttbzHKKZb2CuERwpgrcrOeKcrBBcE_sMkmZrgQveok5fn_ZYnX0tHTCNWruFkatXmbs-w3Uew4QUCjNWl3ndsJDlivUpRJuHkByxyYl4GE9Yi6Aw4'
    };
    Map<String, dynamic> body = {
      "registration_ids": [
        userModel!.tokenMessages,
      ],
      "notification": {
        "title": Get.find<UserController>().userModel!.name,
        "body": title+" \n"+content,
        "android_channel_id": "pushnotificationapp",
        "image": AppConstants.BASE_URL +
            AppConstants.UPLOAD_URL +"users/"+
            Get.find<UserController>().userModel!.image!,
        "sound": false
      },
      // "data":{
      //   "user_image": Get.find<UserController>().userModel!.image,
      // }
    };
    final response = await http.post(postUri,headers: requestHeaders,body: jsonEncode(body));

    if(response.statusCode == 200)
    {
      print("send notification");
    }
    else{
      print("send notification error");
    }
    return response;
  }

}