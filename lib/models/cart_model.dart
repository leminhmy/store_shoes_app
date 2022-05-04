
import 'package:store_shoes_app/models/product.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  String? color;
  int? size;
  int? quantity;
  bool? isExist;
  String? time;
  ProductsModel? product;


  CartModel(
      {this.id,
        this.name,
        this.price,
        this.img,
        this.color,
        this.size,
        this.quantity,
        this.isExist,
        this.time,
        this.product,
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    color = json['color'];
    size = json['size'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductsModel.fromJson(json['product']);

  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "color":this.color,
      "size":this.size,
      "quantity":this.quantity,
      "isExist":this.isExist,
      "time":this.time,
      "product":this.product!.toJson(),
    };

  }


}