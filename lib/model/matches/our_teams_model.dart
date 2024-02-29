import 'package:sportk/model/teams_by_season_model.dart';

class OurTeamsModel {
  bool? status;
  int? code;
  String? msg;
  List<TeamBySeasonData>? data;

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
        data: json["data"] == null ? [] : List<TeamBySeasonData>.from(json["data"]!.map((x) => TeamBySeasonData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
