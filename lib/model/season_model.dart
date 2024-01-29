class SeasonModel {
  int? code;
  Query? query;
  List<Result>? results;

  SeasonModel({
    this.code,
    this.query,
    this.results,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        code: json["code"],
        query: json["query"] == null ? null : Query.fromJson(json["query"]),
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "query": query?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Query {
  int? total;
  String? type;
  String? uuid;

  Query({
    this.total,
    this.type,
    this.uuid,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        total: json["total"],
        type: json["type"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "type": type,
        "uuid": uuid,
      };
}

class Result {
  String? id;
  String? competitionId;
  String? year;
  int? hasPlayerStats;
  int? hasTeamStats;
  int? hasTable;
  int? isCurrent;
  int? startTime;
  int? endTime;
  int? updatedAt;

  Result({
    this.id,
    this.competitionId,
    this.year,
    this.hasPlayerStats,
    this.hasTeamStats,
    this.hasTable,
    this.isCurrent,
    this.startTime,
    this.endTime,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        competitionId: json["competition_id"],
        year: json["year"],
        hasPlayerStats: json["has_player_stats"],
        hasTeamStats: json["has_team_stats"],
        hasTable: json["has_table"],
        isCurrent: json["is_current"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "competition_id": competitionId,
        "year": year,
        "has_player_stats": hasPlayerStats,
        "has_team_stats": hasTeamStats,
        "has_table": hasTable,
        "is_current": isCurrent,
        "start_time": startTime,
        "end_time": endTime,
        "updated_at": updatedAt,
      };
}
