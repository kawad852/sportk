class PlayerModel {
    int? code;
    Query? query;
    List<Result>? results;

    PlayerModel({
        this.code,
        this.query,
        this.results,
    });

    factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
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
    String? teamId;
    String? name;
    String? shortName;
    String? logo;
    String? nationalLogo;
    int? birthday;
    int? age;
    int? weight;
    int? height;
    String? countryId;
    String? nationality;
    int? marketValue;
    String? marketValueCurrency;
    int? contractUntil;
    int? preferredFoot;
    List<dynamic>? ability;
    List<dynamic>? characteristics;
    String? position;
    List<dynamic>? positions;
    int? updatedAt;

    Result({
        this.id,
        this.teamId,
        this.name,
        this.shortName,
        this.logo,
        this.nationalLogo,
        this.birthday,
        this.age,
        this.weight,
        this.height,
        this.countryId,
        this.nationality,
        this.marketValue,
        this.marketValueCurrency,
        this.contractUntil,
        this.preferredFoot,
        this.ability,
        this.characteristics,
        this.position,
        this.positions,
        this.updatedAt,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        teamId: json["team_id"],
        name: json["name"],
        shortName: json["short_name"],
        logo: json["logo"],
        nationalLogo: json["national_logo"],
        birthday: json["birthday"],
        age: json["age"],
        weight: json["weight"],
        height: json["height"],
        countryId: json["country_id"],
        nationality: json["nationality"],
        marketValue: json["market_value"],
        marketValueCurrency: json["market_value_currency"],
        contractUntil: json["contract_until"],
        preferredFoot: json["preferred_foot"],
        ability: json["ability"] == null ? [] : List<dynamic>.from(json["ability"]!.map((x) => x)),
        characteristics: json["characteristics"] == null ? [] : List<dynamic>.from(json["characteristics"]!.map((x) => x)),
        position: json["position"],
        positions: json["positions"] == null ? [] : List<dynamic>.from(json["positions"]!.map((x) => x)),
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "team_id": teamId,
        "name": name,
        "short_name": shortName,
        "logo": logo,
        "national_logo": nationalLogo,
        "birthday": birthday,
        "age": age,
        "weight": weight,
        "height": height,
        "country_id": countryId,
        "nationality": nationality,
        "market_value": marketValue,
        "market_value_currency": marketValueCurrency,
        "contract_until": contractUntil,
        "preferred_foot": preferredFoot,
        "ability": ability == null ? [] : List<dynamic>.from(ability!.map((x) => x)),
        "characteristics": characteristics == null ? [] : List<dynamic>.from(characteristics!.map((x) => x)),
        "position": position,
        "positions": positions == null ? [] : List<dynamic>.from(positions!.map((x) => x)),
        "updated_at": updatedAt,
    };
}
