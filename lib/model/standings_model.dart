class StandingsModel {
    List<Datum>? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    StandingsModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory StandingsModel.fromJson(Map<String, dynamic> json) => StandingsModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        subscription: json["subscription"] == null ? [] : List<Subscription>.from(json["subscription"]!.map((x) => Subscription.fromJson(x))),
        rateLimit: json["rate_limit"] == null ? null : RateLimit.fromJson(json["rate_limit"]),
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "subscription": subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
    };
}

class Datum {
    int? id;
    int? participantId;
    int? sportId;
    int? leagueId;
    int? seasonId;
    int? stageId;
    dynamic groupId;
    int? roundId;
    int? standingRuleId;
    int? position;
    String? result;
    int? points;
    List<Detail>? details;

    Datum({
        this.id,
        this.participantId,
        this.sportId,
        this.leagueId,
        this.seasonId,
        this.stageId,
        this.groupId,
        this.roundId,
        this.standingRuleId,
        this.position,
        this.result,
        this.points,
        this.details,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        participantId: json["participant_id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        groupId: json["group_id"],
        roundId: json["round_id"],
        standingRuleId: json["standing_rule_id"],
        position: json["position"],
        result: json["result"],
        points: json["points"],
        details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "participant_id": participantId,
        "sport_id": sportId,
        "league_id": leagueId,
        "season_id": seasonId,
        "stage_id": stageId,
        "group_id": groupId,
        "round_id": roundId,
        "standing_rule_id": standingRuleId,
        "position": position,
        "result": result,
        "points": points,
        "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
    };
}

class Detail {
    int? id;
    String? standingType;
    int? standingId;
    int? typeId;
    int? value;
    Type? type;

    Detail({
        this.id,
        this.standingType,
        this.standingId,
        this.typeId,
        this.value,
        this.type,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        standingType: json["standing_type"]!,
        standingId: json["standing_id"],
        typeId: json["type_id"],
        value: json["value"],
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "standing_type": standingType,
        "standing_id": standingId,
        "type_id": typeId,
        "value": value,
        "type": type?.toJson(),
    };
}

enum StandingType {
    standing
}

final standingTypeValues = EnumValues({
    "standing": StandingType.standing
});

class Type {
    int? id;
    String? name;
    String? code;
    String? developerName;
    String? modelType;
    String? statGroup;

    Type({
        this.id,
        this.name,
        this.code,
        this.developerName,
        this.modelType,
        this.statGroup,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        developerName: json["developer_name"],
        modelType: json["model_type"],
        statGroup: json["stat_group"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "developer_name": developerName,
        "model_type": modelType,
        "stat_group": statGroup,
    };
}

enum ModelType {
    standings
}

final modelTypeValues = EnumValues({
    "standings": ModelType.standings
});

enum  StatGroup {
    away,
    home,
    overall,
}

final statGroupValues = EnumValues({
    "away": StatGroup.away,
    "home": StatGroup.home,
    "overall": StatGroup.overall
});

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
    List<dynamic>? widgets;

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
        widgets: json["widgets"] == null ? [] : List<dynamic>.from(json["widgets"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "widgets": widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x)),
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

    Meta({
        this.trialEndsAt,
        this.endsAt,
    });

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        trialEndsAt: json["trial_ends_at"] == null ? null : DateTime.parse(json["trial_ends_at"]),
        endsAt: json["ends_at"] == null ? null : DateTime.parse(json["ends_at"]),
    );

    Map<String, dynamic> toJson() => {
        "trial_ends_at": trialEndsAt?.toIso8601String(),
        "ends_at": endsAt?.toIso8601String(),
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

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
