
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  final String appBaseUrl;
  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({
    required this.appBaseUrl
    }){
    baseUrl = appBaseUrl;
    token = "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization':'Bearer $token',
    };
  }

  Future<Response> getData(
      String uri, {Map<String, String>? headers}
      )async{
      try{
        Response response = await get(uri, headers: headers??_mainHeaders);
        return response;
      }catch(e){
        return Response(statusCode: 1, statusText: e.toString());
      }
  }
}