

import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_contants.dart';
import '../api/api_client.dart';

class MessagesRepo{
  final ApiClient apiClient;
  MessagesRepo({required this.apiClient});

  Future<Response> getMessages()async{
    return await apiClient.getData(AppConstants.MESSAGES_GET_URI);
  }

  Future<Response> sendMessages(dynamic body)async{
    return await apiClient.postData(AppConstants.MESSAGES_SEND_URI,body);
  }
}