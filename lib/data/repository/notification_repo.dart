import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_contants.dart';
import '../api/api_client.dart';

class NotificationRepo{
  final ApiClient apiClient;
  NotificationRepo({required this.apiClient});



  Future<Response> getNotification()async{
    return await apiClient.getData(AppConstants.NOTIFICATION_GET_URI);
  }

}