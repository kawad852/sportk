class CompetitionModel {
  int? code;
  Query? query;
  List<Result>? results;

  CompetitionModel({
    this.code,
    this.query,
    this.results,
  });

  CompetitionModel copyWith({
    int? code,
    Query? query,
    List<Result>? results,
  }) =>
      CompetitionModel(
        code: code ?? this.code,
        query: query ?? this.query,
        results: results ?? this.results,
      );

  factory CompetitionModel.fromJson(Map<String, dynamic> json) => CompetitionModel(
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

  Query copyWith({
    int? total,
    String? type,
    String? uuid,
  }) =>
      Query(
        total: total ?? this.total,
        type: type ?? this.type,
        uuid: uuid ?? this.uuid,
      );

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
  String? categoryId;
  String? countryId;
  String? name;
  String? shortName;
  String? logo;
  int? type;
  String? curSeasonId;
  String? curStageId;
  int? curRound;
  int? roundCount;
  List<dynamic>? titleHolder;
  List<dynamic>? mostTitles;
  List<dynamic>? newcomers;
  List<dynamic>? divisions;
  Host? host;
  String? primaryColor;
  String? secondaryColor;
  int? updatedAt;

  Result({
    this.id,
    this.categoryId,
    this.countryId,
    this.name,
    this.shortName,
    this.logo,
    this.type,
    this.curSeasonId,
    this.curStageId,
    this.curRound,
    this.roundCount,
    this.titleHolder,
    this.mostTitles,
    this.newcomers,
    this.divisions,
    this.host,
    this.primaryColor,
    this.secondaryColor,
    this.updatedAt,
  });

  Result copyWith({
    String? id,
    String? categoryId,
    String? countryId,
    String? name,
    String? shortName,
    String? logo,
    int? type,
    String? curSeasonId,
    String? curStageId,
    int? curRound,
    int? roundCount,
    List<dynamic>? titleHolder,
    List<dynamic>? mostTitles,
    List<dynamic>? newcomers,
    List<dynamic>? divisions,
    Host? host,
    String? primaryColor,
    String? secondaryColor,
    int? updatedAt,
  }) =>
      Result(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        countryId: countryId ?? this.countryId,
        name: name ?? this.name,
        shortName: shortName ?? this.shortName,
        logo: logo ?? this.logo,
        type: type ?? this.type,
        curSeasonId: curSeasonId ?? this.curSeasonId,
        curStageId: curStageId ?? this.curStageId,
        curRound: curRound ?? this.curRound,
        roundCount: roundCount ?? this.roundCount,
        titleHolder: titleHolder ?? this.titleHolder,
        mostTitles: mostTitles ?? this.mostTitles,
        newcomers: newcomers ?? this.newcomers,
        divisions: divisions ?? this.divisions,
        host: host ?? this.host,
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        categoryId: json["category_id"],
        countryId: json["country_id"],
        name: json["name"],
        shortName: json["short_name"],
        logo: json["logo"],
        type: json["type"],
        curSeasonId: json["cur_season_id"],
        curStageId: json["cur_stage_id"],
        curRound: json["cur_round"],
        roundCount: json["round_count"],
        titleHolder: json["title_holder"] == null ? [] : List<dynamic>.from(json["title_holder"]!.map((x) => x)),
        mostTitles: json["most_titles"] == null ? [] : List<dynamic>.from(json["most_titles"]!.map((x) => x)),
        newcomers: json["newcomers"] == null ? [] : List<dynamic>.from(json["newcomers"]!.map((x) => x)),
        divisions: json["divisions"] == null ? [] : List<dynamic>.from(json["divisions"]!.map((x) => x)),
        host: json["host"] == null ? null : Host.fromJson(json["host"]),
        primaryColor: json["primary_color"],
        secondaryColor: json["secondary_color"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "country_id": countryId,
        "name": name,
        "short_name": shortName,
        "logo": logo,
        "type": type,
        "cur_season_id": curSeasonId,
        "cur_stage_id": curStageId,
        "cur_round": curRound,
        "round_count": roundCount,
        "title_holder": titleHolder == null ? [] : List<dynamic>.from(titleHolder!.map((x) => x)),
        "most_titles": mostTitles == null ? [] : List<dynamic>.from(mostTitles!.map((x) => x)),
        "newcomers": newcomers == null ? [] : List<dynamic>.from(newcomers!.map((x) => x)),
        "divisions": divisions == null ? [] : List<dynamic>.from(divisions!.map((x) => x)),
        "host": host?.toJson(),
        "primary_color": primaryColor,
        "secondary_color": secondaryColor,
        "updated_at": updatedAt,
      };
}

class Host {
  String? country;

  Host({
    this.country,
  });

  Host copyWith({
    String? country,
  }) =>
      Host(
        country: country ?? this.country,
      );

  factory Host.fromJson(Map<String, dynamic> json) => Host(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}
