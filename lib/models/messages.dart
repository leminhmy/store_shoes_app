class MessagesModel{
  int? id;
  int? idSend;
  int? idTake;
  String? messaging;
  String? image;
  String? createdAt;
  String? updatedAt;

  MessagesModel({
    this.id,
    this.idSend,
    this.idTake,
    this.messaging,
    this.image,
    this.createdAt,
    this.updatedAt
  });

  MessagesModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    idSend = json['id_send'];
    idTake = json['id_take'];
    messaging = json['messaging'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "id_send": this.idSend,
      "id_take": this.idTake,
      "messaging": this.messaging,
      "image": this.image,
      "createdAt": this.createdAt,
      "updatedAt": this.updatedAt,
    };
  }
}