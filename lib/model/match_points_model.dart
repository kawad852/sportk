class MatchPointsModel {
  bool? status;
  int? code;
  String? msg;
  PointsData? data;

  MatchPointsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory MatchPointsModel.fromJson(Map<String, dynamic> json) => MatchPointsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : PointsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class PointsData {
  String? name;
  String? matchId;
  String? homeId;
  String? homeName;
  String? homeLogo;
  String? awayId;
  String? awayName;
  String? awayLogo;
  dynamic firstScorer;
  int? firstScorerPoints;
  int? teamsScorePoints;
  int? matchResultPoints;
  String? matchResult;
  String? resultDisplay;
  DateTime? matchTime;
  String? competitionName;
  String? competitionLogo;
  String? competitionId;
  int? status;
  int? statusSoon;
  TotalPredictions? totalPredictions;

  PointsData({
    this.name,
    this.matchId,
    this.homeId,
    this.homeName,
    this.homeLogo,
    this.awayId,
    this.awayName,
    this.awayLogo,
    this.firstScorer,
    this.firstScorerPoints,
    this.teamsScorePoints,
    this.matchResultPoints,
    this.matchResult,
    this.resultDisplay,
    this.matchTime,
    this.competitionName,
    this.competitionLogo,
    this.competitionId,
    this.status,
    this.statusSoon,
    this.totalPredictions,
  });

  factory PointsData.fromJson(Map<String, dynamic> json) => PointsData(
        name: json["name"],
        matchId: json["match_id"],
        homeId: json["home_id"],
        homeName: json["home_name"],
        homeLogo: json["home_logo"],
        awayId: json["away_id"],
        awayName: json["away_name"],
        awayLogo: json["away_logo"],
        firstScorer: json["first_scorer"],
        firstScorerPoints: json["first_scorer_points"],
        teamsScorePoints: json["teams_score_points"],
        matchResultPoints: json["match_result_points"],
        matchResult: json["match_result"],
        resultDisplay: json["result_display"],
        matchTime: json["match_time"] == null ? null : DateTime.parse(json["match_time"]),
        competitionName: json["competition_name"],
        competitionLogo: json["competition_logo"],
        competitionId: json["competition_id"],
        status: json["status"],
        statusSoon: json["status_soon"],
        totalPredictions: json["total_predictions"] == null
            ? null
            : TotalPredictions.fromJson(json["total_predictions"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "match_id": matchId,
        "home_id": homeId,
        "home_name": homeName,
        "home_logo": homeLogo,
        "away_id": awayId,
        "away_name": awayName,
        "away_logo": awayLogo,
        "first_scorer": firstScorer,
        "first_scorer_points": firstScorerPoints,
        "teams_score_points": teamsScorePoints,
        "match_result_points": matchResultPoints,
        "match_result": matchResult,
        "result_display": resultDisplay,
        "match_time": matchTime?.toIso8601String(),
        "competition_name": competitionName,
        "competition_logo": competitionLogo,
        "competition_id": competitionId,
        "status": status,
        "status_soon": statusSoon,
        "total_predictions": totalPredictions?.toJson(),
      };
}

class TotalPredictions {
  int? id;
  int? home;
  int? away;
  int? draw;

  TotalPredictions({
    this.id,
    this.home,
    this.away,
    this.draw,
  });

  factory TotalPredictions.fromJson(Map<String, dynamic> json) => TotalPredictions(
        id: json["id"],
        home: json["home"] is double? json["home"].toInt():json["home"],
        away: json["away"] is double? json["away"].toInt():json["away"],
        draw: json["draw"] is double? json["draw"].toInt():json["draw"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "home": home,
        "away": away,
        "draw": draw,
      };
}
