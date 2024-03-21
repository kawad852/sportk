class PredictionModel {
  bool? status;
  int? code;
  String? msg;
  PredictionData? data;

  PredictionModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) => PredictionModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : PredictionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class PredictionData {
  String? matchId;
  int? userId;
  int? homeScore;
  int? awayScore;
  String? firstScorerId;
  String? firstScorerName;
  String? prediction;
  int? totalPoints;

  PredictionData({
    this.matchId,
    this.userId,
    this.homeScore,
    this.awayScore,
    this.firstScorerId,
    this.firstScorerName,
    this.prediction,
    this.totalPoints,
  });

  factory PredictionData.fromJson(Map<String, dynamic> json) => PredictionData(
        matchId: json["match_id"],
        userId: json["user_id"],
        homeScore: json["home_score"],
        awayScore: json["away_score"],
        firstScorerId: json["first_scorer_id"],
        firstScorerName: json["first_scorer_name"],
        prediction: json["prediction"],
        totalPoints: json["total_points"],
      );

  Map<String, dynamic> toJson() => {
        "match_id": matchId,
        "user_id": userId,
        "home_score": homeScore,
        "away_score": awayScore,
        "first_scorer_id": firstScorerId,
        "first_scorer_name": firstScorerName,
        "prediction": prediction,
        "total_points": totalPoints,
      };
}
