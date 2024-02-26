class ShowLiveModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  ShowLiveModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory ShowLiveModel.fromJson(Map<String, dynamic> json) => ShowLiveModel(
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
  String? link;
  String? name;
  String? matchTime;
  String? matchId;
  String? competitionId;

  Data({
    this.id,
    this.link,
    this.name,
    this.matchTime,
    this.matchId,
    this.competitionId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        link: json["link"],
        name: json["name"],
        matchTime: json["match_time"],
        matchId: json["match_id"],
        competitionId: json["competition_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "link": link,
        "name": name,
        "match_time": matchTime,
        "match_id": matchId,
        "competition_id": competitionId,
      };
}
