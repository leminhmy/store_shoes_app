
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_contants.dart';

class ApiClient extends GetConnect implements GetxService{
  final String appBaseUrl;
  late String token;
  late Map<String, String> _mainHeaders;
  late SharedPreferences sharedPreferences;

  Map<String, String> get mainHeaders => _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
    }){
    baseUrl = appBaseUrl;
    token = sharedPreferences.getString(AppConstants.TOKEN)??"";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      // 'Content-Type':'multipart/form-data',
      'Authorization':'Bearer $token',
      'Accept': 'application/json',
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      // 'Content-Type':'multipart/form-data',
      // 'Authorization': 'key=AAAAJuMHBZc:APA91bHvuk9es6StPAAfjVyEyYmttbzHKKZb2CuERwpgrcrOeKcrBBcE_sMkmZrgQveok5fn_ZYnX0tHTCNWruFkatXmbs-w3Uew4QUCjNWl3ndsJDlivUpRJuHkByxyYl4GE9Yi6Aw4',
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  Future<Response> getData(
      String uri, {Map<String, String>? headers}
      )async{
      try{
        Response response = await get(uri, headers: headers??_mainHeaders);

        return response;
      }catch(e){
        return Response(statusCode: 200, statusText: e.toString());
      }
  }

  getMainHeader(){
    return _mainHeaders;
  }

  Future<Response> postData(String uri, dynamic body) async{
    print(body.toString());
    try{
      Response response =  await post(uri, body,headers: _mainHeaders);
      return response;
    }catch(e){
      return Response(statusCode: 200,statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri) async{
    try{
      Response response =  await delete(uri,headers: _mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 200,statusText: e.toString());
    }
  }
  Future<Response> putData(String uri,dynamic body) async{
    try{
      Response response =  await put(uri, body,headers: _mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 200,statusText: e.toString());
    }
  }
  Future<Response> postDataNotification(String uri,dynamic body) async{
    var mainHeaders = {
      'Content-type': 'application/json',
      'Authorization': 'key=AAAAJuMHBZc:APA91bHvuk9es6StPAAfjVyEyYmttbzHKKZb2CuERwpgrcrOeKcrBBcE_sMkmZrgQveok5fn_ZYnX0tHTCNWruFkatXmbs-w3Uew4QUCjNWl3ndsJDlivUpRJuHkByxyYl4GE9Yi6Aw4',

    };

    try{
      Response response =  await post(uri, body,headers: mainHeaders);
      print(response.toString());
      return response;
    }catch(e){
      print(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }
}