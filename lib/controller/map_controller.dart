

import 'dart:convert';

import 'package:get/get.dart';
import 'package:store_shoes_app/data/repository/map_json_repo.dart';
import 'package:store_shoes_app/models/map_model.dart';

class MapController extends GetxController{
  final MapJsonRepo mapJsonRepo;

  MapController({required this.mapJsonRepo});


  List<MapModel> _mapProvine = [];
  List<MapModel> get mapProvine => _mapProvine;

  List<MapModel> _mapDistrict = [];
  List<MapModel> get mapDistrict => _mapDistrict;

  List<MapModel> _mapCommune = [];
  List<MapModel> get mapCommune => _mapCommune;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getMapProvine() async {
    _isLoading =false;
    Response response = await mapJsonRepo.getMapProvine();
    if (response.statusCode == 200) {

      _mapProvine = [];
      response.body.forEach((v) {
        _mapProvine.add(MapModel.fromJson(v));
      });
      _isLoading = true;
    } else {
      print("get  map error");
    }
    update();
   /* var testList = [];
    _mapProvine.forEach((element) {
      testList.add(jsonEncode(element));
    }
    );
    print(testList);*/
  }

  clearMap(){
    _mapDistrict = [];
    _mapCommune = [];
    update();
  }

  Future<void> getMapDistrict(String idProvince) async {
    _mapDistrict = [];
    _mapCommune = [];
    Response response = await mapJsonRepo.getMapDistrict(idProvince);
    if (response.statusCode == 200) {
      response.body.forEach((v) {
        _mapDistrict.add(MapModel.fromJson(v));
      });
      print("called success");
    } else {
      print(response.status.code);
    }

    update();

  }
  Future<void> getMapCommune(String idDistrict) async {
    _mapCommune = [];
    Response response = await mapJsonRepo.getMapCommune(idDistrict);
    if (response.statusCode == 200) {

      response.body.forEach((v) {
        _mapCommune.add(MapModel.fromJson(v));
      });

    } else {
      print("get  map error");
    }


    update();

  }

}