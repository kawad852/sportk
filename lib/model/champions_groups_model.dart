class ChampionsGroupsModel {
    List<Datum>? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    ChampionsGroupsModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory ChampionsGroupsModel.fromJson(Map<String, dynamic> json) => ChampionsGroupsModel(
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
    int? groupId;
    int? roundId;
    int? standingRuleId;
    int? position;
    String? result;
    int? points;
    Group? group;

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
        this.group,
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
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
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
        "group": group?.toJson(),
    };
}

class Group {
    int? id;
    int? sportId;
    int? leagueId;
    int? seasonId;
    int? stageId;
    String? name;
    DateTime? startingAt;
    DateTime? endingAt;
    bool? gamesInCurrentWeek;
    bool? isCurrent;
    bool? finished;
    bool? pending;

    Group({
        this.id,
        this.sportId,
        this.leagueId,
        this.seasonId,
        this.stageId,
        this.name,
        this.startingAt,
        this.endingAt,
        this.gamesInCurrentWeek,
        this.isCurrent,
        this.finished,
        this.pending,
    });

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        name: json["name"],
        startingAt: json["starting_at"] == null ? null : DateTime.parse(json["starting_at"]),
        endingAt: json["ending_at"] == null ? null : DateTime.parse(json["ending_at"]),
        gamesInCurrentWeek: json["games_in_current_week"],
        isCurrent: json["is_current"],
        finished: json["finished"],
        pending: json["pending"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "season_id": seasonId,
        "stage_id": stageId,
        "name": name,
        "starting_at": "${startingAt!.year.toString().padLeft(4, '0')}-${startingAt!.month.toString().padLeft(2, '0')}-${startingAt!.day.toString().padLeft(2, '0')}",
        "ending_at": "${endingAt!.year.toString().padLeft(4, '0')}-${endingAt!.month.toString().padLeft(2, '0')}-${endingAt!.day.toString().padLeft(2, '0')}",
        "games_in_current_week": gamesInCurrentWeek,
        "is_current": isCurrent,
        "finished": finished,
        "pending": pending,
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
