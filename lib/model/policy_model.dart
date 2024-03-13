class PolicyModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  PolicyModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? title;
  String? description;

  Data({
    this.id,
    this.title,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
