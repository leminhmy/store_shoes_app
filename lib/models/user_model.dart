class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  int? status;
  String? image;
  String? tokenMessages;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.image,
    required this.tokenMessages,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){

    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        status: json['status'],
        image: json['image'],
        tokenMessages: json['token_messages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "phone": this.phone,
      "status": this.status,
      "image": this.image,
      "token_messages": this.tokenMessages,
    };
  }
}
