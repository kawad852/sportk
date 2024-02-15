class PlayerStatisticsModel {
    Data? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    PlayerStatisticsModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory PlayerStatisticsModel.fromJson(Map<String, dynamic> json) => PlayerStatisticsModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        subscription: json["subscription"] == null ? [] : List<Subscription>.from(json["subscription"]!.map((x) => Subscription.fromJson(x))),
        rateLimit: json["rate_limit"] == null ? null : RateLimit.fromJson(json["rate_limit"]),
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "subscription": subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
    };
}

class Data {
    int? id;
    int? sportId;
    int? countryId;
    int? nationalityId;
    dynamic cityId;
    int? positionId;
    int? detailedPositionId;
    int? typeId;
    String? commonName;
    String? firstname;
    String? lastname;
    String? name;
    String? displayName;
    String? imagePath;
    int? height;
    int? weight;
    DateTime? dateOfBirth;
    String? gender;
    List<Statistic>? statistics;

    Data({
        this.id,
        this.sportId,
        this.countryId,
        this.nationalityId,
        this.cityId,
        this.positionId,
        this.detailedPositionId,
        this.typeId,
        this.commonName,
        this.firstname,
        this.lastname,
        this.name,
        this.displayName,
        this.imagePath,
        this.height,
        this.weight,
        this.dateOfBirth,
        this.gender,
        this.statistics,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        nationalityId: json["nationality_id"],
        cityId: json["city_id"],
        positionId: json["position_id"],
        detailedPositionId: json["detailed_position_id"],
        typeId: json["type_id"],
        commonName: json["common_name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        name: json["name"],
        displayName: json["display_name"],
        imagePath: json["image_path"],
        height: json["height"],
        weight: json["weight"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        statistics: json["statistics"] == null ? [] : List<Statistic>.from(json["statistics"]!.map((x) => Statistic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "nationality_id": nationalityId,
        "city_id": cityId,
        "position_id": positionId,
        "detailed_position_id": detailedPositionId,
        "type_id": typeId,
        "common_name": commonName,
        "firstname": firstname,
        "lastname": lastname,
        "name": name,
        "display_name": displayName,
        "image_path": imagePath,
        "height": height,
        "weight": weight,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
    };
}

class Statistic {
    int? id;
    int? playerId;
    int? teamId;
    int? seasonId;
    bool? hasValues;
    int? positionId;
    int? jerseyNumber;
    List<Detail>? details;

    Statistic({
        this.id,
        this.playerId,
        this.teamId,
        this.seasonId,
        this.hasValues,
        this.positionId,
        this.jerseyNumber,
        this.details,
    });

    factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        id: json["id"],
        playerId: json["player_id"],
        teamId: json["team_id"],
        seasonId: json["season_id"],
        hasValues: json["has_values"],
        positionId: json["position_id"],
        jerseyNumber: json["jersey_number"],
        details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "team_id": teamId,
        "season_id": seasonId,
        "has_values": hasValues,
        "position_id": positionId,
        "jersey_number": jerseyNumber,
        "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    };
}

class Detail {
    int? id;
    int? playerStatisticId;
    int? typeId;
    Value? value;

    Detail({
        this.id,
        this.playerStatisticId,
        this.typeId,
        this.value,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        playerStatisticId: json["player_statistic_id"],
        typeId: json["type_id"],
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "player_statistic_id": playerStatisticId,
        "type_id": typeId,
        "value": value?.toJson(),
    };
}

class Value {
    double? total;
    int? goals;
    int? penalties;
    int? valueIn;
    int? out;
    double? average;
    double? highest;
    double? lowest;

    Value({
        this.total,
        this.goals,
        this.penalties,
        this.valueIn,
        this.out,
        this.average,
        this.highest,
        this.lowest,
    });

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        total: json["total"]?.toDouble(),
        goals: json["goals"],
        penalties: json["penalties"],
        valueIn: json["in"],
        out: json["out"],
        average: json["average"]?.toDouble(),
        highest: json["highest"]?.toDouble(),
        lowest: json["lowest"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "goals": goals,
        "penalties": penalties,
        "in": valueIn,
        "out": out,
        "average": average,
        "highest": highest,
        "lowest": lowest,
    };
}

class RateLimit {
    int? resetsInSeconds;
    int? remaining;
    String? requestedEntity;

    RateLimit({
        this.resetsInSeconds,
        this.remaining,
        this.requestedEntity,
    });

    factory RateLimit.fromJson(Map<String, dynamic> json) => RateLimit(
        resetsInSeconds: json["resets_in_seconds"],
        remaining: json["remaining"],
        requestedEntity: json["requested_entity"],
    );

    Map<String, dynamic> toJson() => {
        "resets_in_seconds": resetsInSeconds,
        "remaining": remaining,
        "requested_entity": requestedEntity,
    };
}

class Subscription {
    Meta? meta;
    List<Plan>? plans;
    List<AddOn>? addOns;
    List<Widgets>? widgets;

    Subscription({
        this.meta,
        this.plans,
        this.addOns,
        this.widgets,
    });

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        plans: json["plans"] == null ? [] : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        addOns: json["add_ons"] == null ? [] : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        widgets: json["widgets"] == null ? [] : List<Widgets>.from(json["widgets"]!.map((x) => Widgets.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "widgets": widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x.toJson())),
    };
}

class AddOn {
    String? addOn;
    String? sport;
    String? category;

    AddOn({
        this.addOn,
        this.sport,
        this.category,
    });

    factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        addOn: json["add_on"],
        sport: json["sport"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "add_on": addOn,
        "sport": sport,
        "category": category,
    };
}

class Meta {
    DateTime? trialEndsAt;
    DateTime? endsAt;
    int? currentTimestamp;

    Meta({
        this.trialEndsAt,
        this.endsAt,
        this.currentTimestamp,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        trialEndsAt: json["trial_ends_at"] == null ? null : DateTime.parse(json["trial_ends_at"]),
        endsAt: json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
        currentTimestamp: json["current_timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "trial_ends_at": trialEndsAt?.toIso8601String(),
        "ends_at": endsAt?.toIso8601String(),
        "current_timestamp": currentTimestamp,
    };
}

class Plan {
    String? plan;
    String? sport;
    String? category;

    Plan({
        this.plan,
        this.sport,
        this.category,
    });

    factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        plan: json["plan"],
        sport: json["sport"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "plan": plan,
        "sport": sport,
        "category": category,
    };
}

class Widgets {
    String? widget;
    String? sport;

    Widgets({
        this.widget,
        this.sport,
    });

    factory Widgets.fromJson(Map<String, dynamic> json) => Widgets(
        widget: json["widget"],
        sport: json["sport"],
    );

    Map<String, dynamic> toJson() => {
        "widget": widget,
        "sport": sport,
    };
}
