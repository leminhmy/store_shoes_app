import 'dart:convert';

import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/notification_repo.dart';

import '../models/notification_model.dart';
import '../models/responseModel.dart';

class NotificationController extends GetxController{

    final NotificationRepo notificationRepo;

    NotificationController({required this.notificationRepo});

  List<NotificationModel> _listNotification = [];
  List<NotificationModel> get listNotification => _listNotification;

  Future<ResponseModel> getNotification() async {

      Response response = await notificationRepo.getNotification();
      late ResponseModel responseModel;
      if (response.statusCode == 200) {
        _listNotification = [];
        response.body.forEach((v) {
          _listNotification.add(NotificationModel.fromJson(v));
        });
        responseModel = ResponseModel(true, "successfully");
      } else {
        responseModel = ResponseModel(false, response.statusText!);
      }


      update();
      return responseModel;
    }

}