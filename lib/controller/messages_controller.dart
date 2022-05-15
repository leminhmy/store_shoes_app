import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:store_shoes_app/controller/auth_controller.dart';
import 'package:store_shoes_app/controller/user_controller.dart';
import 'package:store_shoes_app/data/repository/messages_repo.dart';
import 'package:store_shoes_app/models/messages.dart';

import '../models/responseModel.dart';

class MessagesController extends GetxController{
  final MessagesRepo messagesRepo;
  
  MessagesController({required this.messagesRepo});

  
  List<MessagesModel> _listMessages = [];
  List<MessagesModel> get listMessages => _listMessages;


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
   /* var testList = [];
    _listMessages.forEach((element) {
      testList.add(jsonEncode(element));
    }
    );
    print(testList);*/
    return responseModel;
  }

  getMessagesPeople(int idPeople){
    List<MessagesModel> listMessagesPeople = [];
    if(Get.find<AuthController>().userLoggedIn()){
      int userId = Get.find<UserController>().getUserId();
      _listMessages.forEach((element) {
        if(element.idSend == userId && element.idTake == idPeople || element.idSend == idPeople && element.idTake == userId){
          listMessagesPeople.add(element);
        }
      });
     /* var testList = [];
      listMessagesPeople.forEach((element) {
        testList.add(jsonEncode(element));
      }
      );
      print(testList);*/
    }
    else{
      print("user chua login");
    }
    update();
    return listMessagesPeople;

  }
  
}