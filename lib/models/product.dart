class Product{
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductsModel> _products;
  List<ProductsModel> get products =>  _products;

  Product({required totalSize,required typeId,required offset, required products}){
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _products = <ProductsModel>[];
      json['products'].forEach((v) {
        _products.add(ProductsModel.fromJson(v));
      });
    }
  }
}


class ProductsModel{
  int? id;
  String? name;
  String? subTitle;
  int? price;
  String? color;
  String? size;
  int? typeId;
  String? description;
  String? img;
  String? listimg;
  String? createdAt;
  String? updatedAt;

  ProductsModel({
    this.id,
    this.name,
    this.subTitle,
    this.price,
    this.color,
    this.size,
    this.typeId,
    this.description,
    this.listimg,
    this.img,
    this.createdAt,
    this.updatedAt,
});

  ProductsModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    subTitle = json['sub_title'];
    price = json['price'];
    color = json['color'];
    size = json['size'];
    typeId = json['type_id'];
    description = json['description'];
    img = json['img'];
    listimg = json['listimg'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "subTitle": this.subTitle,
      "price": this.price,
      "color": this.color,
      "size": this.size,
      "typeId": this.typeId,
      "description": this.description,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
      "img": this.img,
      "listimg":this.listimg
    };
  }
}