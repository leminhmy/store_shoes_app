class ShoesType{
  int? _totalSize;
  int? _parentId;
  late List<ShoesTypeModel> _shoesType;
  List<ShoesTypeModel> get shoesType =>  _shoesType;

  ShoesType({required totalSize,required parentId, required shoesType}){
    this._totalSize = totalSize;
    this._parentId = parentId;
    this._shoesType = shoesType;
  }

  ShoesType.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _parentId = json['_parent_id'];
    if (json['shoes_type'] != null) {
      _shoesType = <ShoesTypeModel>[];
      json['shoes_type'].forEach((v) {
        _shoesType.add(ShoesTypeModel.fromJson(v));
      });
    }
  }
}


class ShoesTypeModel{
  int? id;
  String? name;
  int? parentId;
  String? createdAt;
  String? updatedAt;

  ShoesTypeModel({
    this.id,
    this.name,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  ShoesTypeModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['title'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.name,
      "parentId": this.parentId,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}