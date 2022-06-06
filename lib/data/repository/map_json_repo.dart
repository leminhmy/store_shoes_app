import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/app_contants.dart';
import '../api/api_client.dart';

class MapJsonRepo{
  final ApiClient apiClient;
  MapJsonRepo({required this.apiClient});

  Future<Response> getMapProvine()async{
    return await apiClient.getData(AppConstants.MAP_PROVINE_URI);
  }

  Future<Response> getMapDistrict(String idProvince)async{
    return await apiClient.getData(AppConstants.MAP_DISTRICT_URI+"/"+idProvince);
  }

  Future<Response> getMapCommune(String idDistrict)async{
    return await apiClient.getData(AppConstants.MAP_COMMUNE_URI+"/"+idDistrict);
  }

}