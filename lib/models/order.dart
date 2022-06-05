class OrderList{
  int? _totalSize;
  late List<Order> _orders;
  List<Order> get orders => _orders;

  OrderList({required totalSize, required orders}){
    this._totalSize = totalSize;
    this._orders = orders;
  }

  OrderList.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    if (json['orders'] != null) {
      _orders = <Order>[];
      json['orders'].forEach((v) {
        _orders.add(Order.fromJson(v));
      });
    }
  }
}

class Order{
  int? id;
  int? userId;
  int? orderAmount;
  int? phone;
  int? status;
  String? address;
  String? message;
  String? createdAt;
  String? updatedAt;
  List<OrderModel>? orderItems;

  Order({
    this.id,
    this.userId,
    this.orderAmount,
    this.phone,
    this.status,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  Order.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'];
    phone = json['phone'];
    status = json['status'];
    address = json['address'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_items'] != null) {
      orderItems = <OrderModel>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "userId": this.userId,
      "orderAmount": this.orderAmount,
      "phone": this.phone,
      "status": this.status,
      "address": this.address,
      "message": this.message,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}


class OrderModel{
  int? id;
  int? ordersId;
  int? productId;
  String? name;
  String? img;
  String? color;
  int? size;
  String? shoesDetails;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;

  OrderModel({
    this.id,
    this.ordersId,
    this.productId,
    this.name,
    this.img,
    this.color,
    this.size,
    this.shoesDetails,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    ordersId = json['orders_id'];
    productId = json['product_id'];
    name = json['name'];
    img = json['img'];
    color = json['color'];
    size = json['size'];
    shoesDetails = json['shoes_details'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }


  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "ordersId": this.ordersId,
      "productId": this.productId,
      "name": this.name,
      "img": this.img,
      "color": this.color,
      "size": this.size,
      "shoesDetails": this.shoesDetails,
      "quantity": this.quantity,
      "price": this.createdAt,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }

}