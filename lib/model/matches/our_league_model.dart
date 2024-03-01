import 'package:sportk/model/league_model.dart';

class OurLeaguesModel {
  bool? status;
  int? code;
  String? msg;
  List<LeagueData>? data;

  OurLeaguesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory OurLeaguesModel.fromJson(Map<String, dynamic> json) => OurLeaguesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<LeagueData>.from(json["data"]!.map((x) => LeagueData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

// class OurLeagueData {
//   String? id;
//   String? name;
//   int? status;
//   String? logo;
//   String? createdAt;
//   String? updatedAt;
//
//   OurLeagueData({
//     this.id,
//     this.name,
//     this.status,
//     this.logo,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory OurLeagueData.fromJson(Map<String, dynamic> json) => OurLeagueData(
//         id: json["id"],
//         name: json["name"],
//         status: json["status"],
//         logo: json["logo"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "status": status,
//         "logo": logo,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
