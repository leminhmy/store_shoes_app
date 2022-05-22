class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int status;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){

    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        status: json['status'],
    );
  }
}
