
import 'package:get/get.dart';

import '../data/repository/user_repo.dart';
import '../models/responseModel.dart';
import '../models/user_model.dart';



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
  Future<ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      if(_userModel!.status == 2){
        _userIsAdmin = true;
      }
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }


}