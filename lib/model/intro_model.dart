class IntroModel {
  bool? status;
  int? code;
  String? msg;
  List<IntroData>? data;

  IntroModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory IntroModel.fromJson(Map<String, dynamic> json) => IntroModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<IntroData>.from(json["data"]!.map((x) => IntroData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class IntroData {
  int? id;
  String? title;
  String? description;
  String? image;

  IntroData({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  factory IntroData.fromJson(Map<String, dynamic> json) => IntroData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
      };
}
