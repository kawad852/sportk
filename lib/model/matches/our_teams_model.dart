class OurTeamsModel {
  bool? status;
  int? code;
  String? msg;
  List<TeamData>? data;

  OurTeamsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory OurTeamsModel.fromJson(Map<String, dynamic> json) => OurTeamsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<TeamData>.from(json["data"]!.map((x) => TeamData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TeamData {
  String? id;
  String? name;
  String? logo;

  TeamData({
    this.id,
    this.name,
    this.logo,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) => TeamData(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
