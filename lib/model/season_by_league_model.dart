class SeasonByLeagueModel {
  Data? data;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  SeasonByLeagueModel({
    this.data,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory SeasonByLeagueModel.fromJson(Map<String, dynamic> json) => SeasonByLeagueModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        subscription: json["subscription"] == null
            ? []
            : List<Subscription>.from(json["subscription"]!.map((x) => Subscription.fromJson(x))),
        rateLimit: json["rate_limit"] == null ? null : RateLimit.fromJson(json["rate_limit"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "subscription":
            subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
      };
}

class Data {
  int? id;
  int? sportId;
  int? countryId;
  String? name;
  bool? active;
  String? shortCode;
  String? imagePath;
  String? type;
  String? subType;
  DateTime? lastPlayedAt;
  int? category;
  bool? hasJerseys;
  Currentseason? currentseason;

  Data({
    this.id,
    this.sportId,
    this.countryId,
    this.name,
    this.active,
    this.shortCode,
    this.imagePath,
    this.type,
    this.subType,
    this.lastPlayedAt,
    this.category,
    this.hasJerseys,
    this.currentseason,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        name: json["name"],
        active: json["active"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        type: json["type"],
        subType: json["sub_type"],
        lastPlayedAt:
            json["last_played_at"] == null ? null : DateTime.parse(json["last_played_at"]),
        category: json["category"],
        hasJerseys: json["has_jerseys"],
        currentseason:
            json["currentseason"] == null ? null : Currentseason.fromJson(json["currentseason"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "name": name,
        "active": active,
        "short_code": shortCode,
        "image_path": imagePath,
        "type": type,
        "sub_type": subType,
        "last_played_at": lastPlayedAt?.toIso8601String(),
        "category": category,
        "has_jerseys": hasJerseys,
        "currentseason": currentseason?.toJson(),
      };
}

class Currentseason {
  int? id;
  int? sportId;
  int? leagueId;
  int? tieBreakerRuleId;
  String? name;
  bool? finished;
  bool? pending;
  bool? isCurrent;
  DateTime? startingAt;
  DateTime? endingAt;
  DateTime? standingsRecalculatedAt;
  bool? gamesInCurrentWeek;

  Currentseason({
    this.id,
    this.sportId,
    this.leagueId,
    this.tieBreakerRuleId,
    this.name,
    this.finished,
    this.pending,
    this.isCurrent,
    this.startingAt,
    this.endingAt,
    this.standingsRecalculatedAt,
    this.gamesInCurrentWeek,
  });

  factory Currentseason.fromJson(Map<String, dynamic> json) => Currentseason(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        tieBreakerRuleId: json["tie_breaker_rule_id"],
        name: json["name"],
        finished: json["finished"],
        pending: json["pending"],
        isCurrent: json["is_current"],
        startingAt: json["starting_at"] == null ? null : DateTime.parse(json["starting_at"]),
        endingAt: json["ending_at"] == null ? null : DateTime.parse(json["ending_at"]),
        standingsRecalculatedAt: json["standings_recalculated_at"] == null
            ? null
            : DateTime.parse(json["standings_recalculated_at"]),
        gamesInCurrentWeek: json["games_in_current_week"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "tie_breaker_rule_id": tieBreakerRuleId,
        "name": name,
        "finished": finished,
        "pending": pending,
        "is_current": isCurrent,
        "starting_at":
            "${startingAt!.year.toString().padLeft(4, '0')}-${startingAt!.month.toString().padLeft(2, '0')}-${startingAt!.day.toString().padLeft(2, '0')}",
        "ending_at":
            "${endingAt!.year.toString().padLeft(4, '0')}-${endingAt!.month.toString().padLeft(2, '0')}-${endingAt!.day.toString().padLeft(2, '0')}",
        "standings_recalculated_at": standingsRecalculatedAt?.toIso8601String(),
        "games_in_current_week": gamesInCurrentWeek,
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
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        addOns: json["add_ons"] == null
            ? []
            : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
        widgets: json["widgets"] == null
            ? []
            : List<Widgets>.from(json["widgets"]!.map((x) => Widgets.fromJson(x))),
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
