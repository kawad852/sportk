import 'package:sportk/model/team_info_model.dart';

class OurTeamsModel {
  bool? status;
  int? code;
  String? msg;
  List<TeamInfoData>? data;

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
        data: json["data"] == null ? [] : List<TeamInfoData>.from(json["data"]!.map((x) => TeamInfoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
