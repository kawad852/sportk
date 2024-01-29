class TeamModel {
  int? code;
  Query? query;
  List<Result>? results;

  TeamModel({
    this.code,
    this.query,
    this.results,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
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
  String? countryId;
  String? name;
  String? shortName;
  String? logo;
  int? national;
  String? countryLogo;
  int? foundationTime;
  String? website;
  String? coachId;
  String? venueId;
  int? marketValue;
  String? marketValueCurrency;
  int? totalPlayers;
  int? foreignPlayers;
  int? nationalPlayers;
  int? updatedAt;

  Result({
    this.id,
    this.competitionId,
    this.countryId,
    this.name,
    this.shortName,
    this.logo,
    this.national,
    this.countryLogo,
    this.foundationTime,
    this.website,
    this.coachId,
    this.venueId,
    this.marketValue,
    this.marketValueCurrency,
    this.totalPlayers,
    this.foreignPlayers,
    this.nationalPlayers,
    this.updatedAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        competitionId: json["competition_id"],
        countryId: json["country_id"],
        name: json["name"],
        shortName: json["short_name"],
        logo: json["logo"],
        national: json["national"],
        countryLogo: json["country_logo"],
        foundationTime: json["foundation_time"],
        website: json["website"],
        coachId: json["coach_id"],
        venueId: json["venue_id"],
        marketValue: json["market_value"],
        marketValueCurrency: json["market_value_currency"],
        totalPlayers: json["total_players"],
        foreignPlayers: json["foreign_players"],
        nationalPlayers: json["national_players"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "competition_id": competitionId,
        "country_id": countryId,
        "name": name,
        "short_name": shortName,
        "logo": logo,
        "national": national,
        "country_logo": countryLogo,
        "foundation_time": foundationTime,
        "website": website,
        "coach_id": coachId,
        "venue_id": venueId,
        "market_value": marketValue,
        "market_value_currency": marketValueCurrency,
        "total_players": totalPlayers,
        "foreign_players": foreignPlayers,
        "national_players": nationalPlayers,
        "updated_at": updatedAt,
      };
}
