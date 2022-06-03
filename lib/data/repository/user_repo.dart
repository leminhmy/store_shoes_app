
import 'package:get/get.dart';

import '../../utils/app_contants.dart';
import '../api/api_client.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});
  
  Future<Response>getUserInfo()async{
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }

  Future<Response>getListUsers()async{
    return await apiClient.getData(AppConstants.MESSAGES_LISTUSERS_URI);
  }

  Future<Response>getListAdmin()async{
    return await apiClient.getData(AppConstants.MESSAGES_LISTADMIN_URI);
  }
}