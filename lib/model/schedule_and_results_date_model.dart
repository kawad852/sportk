class ScheduleAndResultsDateModel {
  int? code;
  Query? query;
  List<Result>? results;
  ResultsExtra? resultsExtra;

  ScheduleAndResultsDateModel({
    this.code,
    this.query,
    this.results,
    this.resultsExtra,
  });

  ScheduleAndResultsDateModel copyWith({
    int? code,
    Query? query,
    List<Result>? results,
    ResultsExtra? resultsExtra,
  }) =>
      ScheduleAndResultsDateModel(
        code: code ?? this.code,
        query: query ?? this.query,
        results: results ?? this.results,
        resultsExtra: resultsExtra ?? this.resultsExtra,
      );

  factory ScheduleAndResultsDateModel.fromJson(Map<String, dynamic> json) => ScheduleAndResultsDateModel(
        code: json["code"],
        query: json["query"] == null ? null : Query.fromJson(json["query"]),
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
        resultsExtra: json["results_extra"] == null ? null : ResultsExtra.fromJson(json["results_extra"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "query": query?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "results_extra": resultsExtra?.toJson(),
      };
}

class Query {
  int? total;
  String? type;

  Query({
    this.total,
    this.type,
  });

  Query copyWith({
    int? total,
    String? type,
  }) =>
      Query(
        total: total ?? this.total,
        type: type ?? this.type,
      );

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        total: json["total"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "type": type,
      };
}

class Result {
  String? id;
  String? seasonId;
  String? competitionId;
  String? homeTeamId;
  String? awayTeamId;
  int? statusId;
  int? matchTime;
  String? venueId;
  String? refereeId;
  int? neutral;
  String? note;
  List<int>? homeScores;
  List<int>? awayScores;
  String? homePosition;
  String? awayPosition;
  Coverage? coverage;
  Round? round;
  Environment? environment;
  int? updatedAt;

  Result({
    this.id,
    this.seasonId,
    this.competitionId,
    this.homeTeamId,
    this.awayTeamId,
    this.statusId,
    this.matchTime,
    this.venueId,
    this.refereeId,
    this.neutral,
    this.note,
    this.homeScores,
    this.awayScores,
    this.homePosition,
    this.awayPosition,
    this.coverage,
    this.round,
    this.environment,
    this.updatedAt,
  });

  Result copyWith({
    String? id,
    String? seasonId,
    String? competitionId,
    String? homeTeamId,
    String? awayTeamId,
    int? statusId,
    int? matchTime,
    String? venueId,
    String? refereeId,
    int? neutral,
    String? note,
    List<int>? homeScores,
    List<int>? awayScores,
    String? homePosition,
    String? awayPosition,
    Coverage? coverage,
    Round? round,
    Environment? environment,
    int? updatedAt,
  }) =>
      Result(
        id: id ?? this.id,
        seasonId: seasonId ?? this.seasonId,
        competitionId: competitionId ?? this.competitionId,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        statusId: statusId ?? this.statusId,
        matchTime: matchTime ?? this.matchTime,
        venueId: venueId ?? this.venueId,
        refereeId: refereeId ?? this.refereeId,
        neutral: neutral ?? this.neutral,
        note: note ?? this.note,
        homeScores: homeScores ?? this.homeScores,
        awayScores: awayScores ?? this.awayScores,
        homePosition: homePosition ?? this.homePosition,
        awayPosition: awayPosition ?? this.awayPosition,
        coverage: coverage ?? this.coverage,
        round: round ?? this.round,
        environment: environment ?? this.environment,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        seasonId: json["season_id"],
        competitionId: json["competition_id"],
        homeTeamId: json["home_team_id"],
        awayTeamId: json["away_team_id"],
        statusId: json["status_id"],
        matchTime: json["match_time"],
        venueId: json["venue_id"],
        refereeId: json["referee_id"],
        neutral: json["neutral"],
        note: json["note"],
        homeScores: json["home_scores"] == null ? [] : List<int>.from(json["home_scores"]!.map((x) => x)),
        awayScores: json["away_scores"] == null ? [] : List<int>.from(json["away_scores"]!.map((x) => x)),
        homePosition: json["home_position"],
        awayPosition: json["away_position"],
        coverage: json["coverage"] == null ? null : Coverage.fromJson(json["coverage"]),
        round: json["round"] == null ? null : Round.fromJson(json["round"]),
        environment: json["environment"] == null ? null : Environment.fromJson(json["environment"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_id": seasonId,
        "competition_id": competitionId,
        "home_team_id": homeTeamId,
        "away_team_id": awayTeamId,
        "status_id": statusId,
        "match_time": matchTime,
        "venue_id": venueId,
        "referee_id": refereeId,
        "neutral": neutral,
        "note": note,
        "home_scores": homeScores == null ? [] : List<dynamic>.from(homeScores!.map((x) => x)),
        "away_scores": awayScores == null ? [] : List<dynamic>.from(awayScores!.map((x) => x)),
        "home_position": homePosition,
        "away_position": awayPosition,
        "coverage": coverage?.toJson(),
        "round": round?.toJson(),
        "environment": environment?.toJson(),
        "updated_at": updatedAt,
      };
}

class Coverage {
  int? mlive;
  int? lineup;

  Coverage({
    this.mlive,
    this.lineup,
  });

  Coverage copyWith({
    int? mlive,
    int? lineup,
  }) =>
      Coverage(
        mlive: mlive ?? this.mlive,
        lineup: lineup ?? this.lineup,
      );

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        mlive: json["mlive"],
        lineup: json["lineup"],
      );

  Map<String, dynamic> toJson() => {
        "mlive": mlive,
        "lineup": lineup,
      };
}

class Environment {
  int? weather;
  String? pressure;
  String? temperature;
  String? wind;
  String? humidity;

  Environment({
    this.weather,
    this.pressure,
    this.temperature,
    this.wind,
    this.humidity,
  });

  Environment copyWith({
    int? weather,
    String? pressure,
    String? temperature,
    String? wind,
    String? humidity,
  }) =>
      Environment(
        weather: weather ?? this.weather,
        pressure: pressure ?? this.pressure,
        temperature: temperature ?? this.temperature,
        wind: wind ?? this.wind,
        humidity: humidity ?? this.humidity,
      );

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
        weather: json["weather"],
        pressure: json["pressure"],
        temperature: json["temperature"],
        wind: json["wind"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "weather": weather,
        "pressure": pressure,
        "temperature": temperature,
        "wind": wind,
        "humidity": humidity,
      };
}

class Round {
  String? stageId;
  int? roundNum;
  int? groupNum;

  Round({
    this.stageId,
    this.roundNum,
    this.groupNum,
  });

  Round copyWith({
    String? stageId,
    int? roundNum,
    int? groupNum,
  }) =>
      Round(
        stageId: stageId ?? this.stageId,
        roundNum: roundNum ?? this.roundNum,
        groupNum: groupNum ?? this.groupNum,
      );

  factory Round.fromJson(Map<String, dynamic> json) => Round(
        stageId: json["stage_id"],
        roundNum: json["round_num"],
        groupNum: json["group_num"],
      );

  Map<String, dynamic> toJson() => {
        "stage_id": stageId,
        "round_num": roundNum,
        "group_num": groupNum,
      };
}

class ResultsExtra {
  List<Competition>? competition;
  List<Competition>? team;
  List<Competition>? referee;
  List<Venue>? venue;
  List<Season>? season;
  List<Stage>? stage;

  ResultsExtra({
    this.competition,
    this.team,
    this.referee,
    this.venue,
    this.season,
    this.stage,
  });

  ResultsExtra copyWith({
    List<Competition>? competition,
    List<Competition>? team,
    List<Competition>? referee,
    List<Venue>? venue,
    List<Season>? season,
    List<Stage>? stage,
  }) =>
      ResultsExtra(
        competition: competition ?? this.competition,
        team: team ?? this.team,
        referee: referee ?? this.referee,
        venue: venue ?? this.venue,
        season: season ?? this.season,
        stage: stage ?? this.stage,
      );

  factory ResultsExtra.fromJson(Map<String, dynamic> json) => ResultsExtra(
        competition: json["competition"] == null ? [] : List<Competition>.from(json["competition"]!.map((x) => Competition.fromJson(x))),
        team: json["team"] == null ? [] : List<Competition>.from(json["team"]!.map((x) => Competition.fromJson(x))),
        referee: json["referee"] == null ? [] : List<Competition>.from(json["referee"]!.map((x) => Competition.fromJson(x))),
        venue: json["venue"] == null ? [] : List<Venue>.from(json["venue"]!.map((x) => Venue.fromJson(x))),
        season: json["season"] == null ? [] : List<Season>.from(json["season"]!.map((x) => Season.fromJson(x))),
        stage: json["stage"] == null ? [] : List<Stage>.from(json["stage"]!.map((x) => Stage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "competition": competition == null ? [] : List<dynamic>.from(competition!.map((x) => x.toJson())),
        "team": team == null ? [] : List<dynamic>.from(team!.map((x) => x.toJson())),
        "referee": referee == null ? [] : List<dynamic>.from(referee!.map((x) => x.toJson())),
        "venue": venue == null ? [] : List<dynamic>.from(venue!.map((x) => x.toJson())),
        "season": season == null ? [] : List<dynamic>.from(season!.map((x) => x.toJson())),
        "stage": stage == null ? [] : List<dynamic>.from(stage!.map((x) => x.toJson())),
      };
}

class Competition {
  String? id;
  String? name;
  String? logo;
  String? countryLogo;

  Competition({
    this.id,
    this.name,
    this.logo,
    this.countryLogo,
  });

  Competition copyWith({
    String? id,
    String? name,
    String? logo,
    String? countryLogo,
  }) =>
      Competition(
        id: id ?? this.id,
        name: name ?? this.name,
        logo: logo ?? this.logo,
        countryLogo: countryLogo ?? this.countryLogo,
      );

  factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        countryLogo: json["country_logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "country_logo": countryLogo,
      };
}

class Season {
  String? id;
  String? competitionId;
  String? year;

  Season({
    this.id,
    this.competitionId,
    this.year,
  });

  Season copyWith({
    String? id,
    String? competitionId,
    String? year,
  }) =>
      Season(
        id: id ?? this.id,
        competitionId: competitionId ?? this.competitionId,
        year: year ?? this.year,
      );

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        id: json["id"],
        competitionId: json["competition_id"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "competition_id": competitionId,
        "year": year,
      };
}

class Stage {
  String? id;
  String? seasonId;
  String? name;
  int? mode;
  int? groupCount;
  int? roundCount;
  int? order;

  Stage({
    this.id,
    this.seasonId,
    this.name,
    this.mode,
    this.groupCount,
    this.roundCount,
    this.order,
  });

  Stage copyWith({
    String? id,
    String? seasonId,
    String? name,
    int? mode,
    int? groupCount,
    int? roundCount,
    int? order,
  }) =>
      Stage(
        id: id ?? this.id,
        seasonId: seasonId ?? this.seasonId,
        name: name ?? this.name,
        mode: mode ?? this.mode,
        groupCount: groupCount ?? this.groupCount,
        roundCount: roundCount ?? this.roundCount,
        order: order ?? this.order,
      );

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        seasonId: json["season_id"],
        name: json["name"],
        mode: json["mode"],
        groupCount: json["group_count"],
        roundCount: json["round_count"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "season_id": seasonId,
        "name": name,
        "mode": mode,
        "group_count": groupCount,
        "round_count": roundCount,
        "order": order,
      };
}

class Venue {
  String? id;
  String? name;

  Venue({
    this.id,
    this.name,
  });

  Venue copyWith({
    String? id,
    String? name,
  }) =>
      Venue(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
