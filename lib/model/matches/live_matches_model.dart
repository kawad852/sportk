class LivesMatchesModel {
  bool? status;
  int? code;
  String? msg;
  LiveData? data;

  LivesMatchesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory LivesMatchesModel.fromJson(Map<String, dynamic> json) => LivesMatchesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : LiveData.fromJson(json["data"]),
        // data: json["data"] == null ? [] : List<LiveData>.from(json["data"]!.map((x) => LiveData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
        // "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class LiveData {
  int? id;
  String? link;
  String? name;
  String? matchTime;
  String? matchId;
  String? competitionId;

  LiveData({
    this.id,
    this.link,
    this.name,
    this.matchTime,
    this.matchId,
    this.competitionId,
  });

  factory LiveData.fromJson(Map<String, dynamic> json) => LiveData(
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
