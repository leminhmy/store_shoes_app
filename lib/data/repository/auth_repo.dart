import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_shoes_app/data/api/api_client.dart';
import 'package:store_shoes_app/models/signup_body_model.dart';
import 'package:store_shoes_app/utils/app_contants.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences
  });

  Future<Response> registration(SignUpBody signUpBody) async{
    return await apiClient.post(AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<Response> login(String email, String password)async{
    return await apiClient.postData(AppConstants.LOGIN_URI, {"email":email, "password":password});
  }

  Future<String> getUserToken()async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  bool userLoggedIn(){
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> saveUserToken(String token)async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password)async{
    try{
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;
  }
}