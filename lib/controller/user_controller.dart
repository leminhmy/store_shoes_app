
import 'dart:convert';

import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/responseModel.dart';
import '../models/user_model.dart';
import '../severs/sever_socketio/socketio_client.dart';



class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });


  bool _isLoading = false;
  // late UserModel _userModel;
  UserModel? _userModel;
  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;
  bool _userIsAdmin = false;
  bool? get userIsAdmin => _userIsAdmin;
  //get listuser or listadmin for chats
  List<UserModel> _listUsersMessages = [];
  List<UserModel> get listUsers => _listUsersMessages;


  Future<ResponseModel> getUserInfo() async {
    _userIsAdmin = false;
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      if(_userModel!.status == 2){
        _userIsAdmin = true;
      }else{
        _userIsAdmin = false;
      }


      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }




    update();
    return responseModel;
  }

  Future<ResponseModel> getListUsers() async {
    _listUsersMessages = [];
    Response response = await userRepo.getListUsers();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      response.body.forEach((v){
        _listUsersMessages.add(UserModel.fromJson(v));
      });
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _listUsersMessages.forEach((element) {
      var testList = [];
      testList.add(jsonEncode(element));
      print(testList);
    }
    );
    update();
    return responseModel;
  }

  Future<ResponseModel> getListAdmin() async {
    _listUsersMessages = [];
    Response response = await userRepo.getListAdmin();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      response.body.forEach((v){
        _listUsersMessages.add(UserModel.fromJson(v));
      });
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _listUsersMessages.forEach((element) {
      var testList = [];
      testList.add(jsonEncode(element));
      print(testList);
    }
    );
    update();
    return responseModel;
  }

}