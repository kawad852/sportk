class LivesMatchesModel {
  bool? status;
  int? code;
  String? msg;
  List<Datum>? data;

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
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? link;
  String? name;
  String? matchTime;
  String? matchId;
  String? competitionId;

  Datum({
    this.id,
    this.link,
    this.name,
    this.matchTime,
    this.matchId,
    this.competitionId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
