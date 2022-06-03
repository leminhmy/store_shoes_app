

import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_contants.dart';
import '../api/api_client.dart';

class MessagesRepo{
  final ApiClient apiClient;
  MessagesRepo({required this.apiClient});

  Future<Response> getMessages()async{
    return await apiClient.getData(AppConstants.MESSAGES_GET_URI);
  }

  Future<Response> getMissMessages()async{
    return await apiClient.getData(AppConstants.MESSAGES_GETMISS_URI);
  }

  Future<Response> setSeeMessages(String userIdTake)async{
    return await apiClient.postData(AppConstants.MESSAGES_SET_SEE_URI,{"userid_take":userIdTake});
  }

  Future<Response> sendMessages(dynamic body)async{
    return await apiClient.postData(AppConstants.MESSAGES_SEND_URI,body);
  }

  Future<Response> sendNotificationMessagesFCM(dynamic body)async{
    return await apiClient.postDataNotification(AppConstants.MESSAGES_SEND_NOTIFICATION_FCM,body);
  }

  Future<Response> saveNotification(dynamic body)async{
    return await apiClient.postData(AppConstants.NOTIFICATION_SAVE_URI,body);
  }

}