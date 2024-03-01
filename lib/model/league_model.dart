class LeagueModel {
  LeagueData? data;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  LeagueModel({
    this.data,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) => LeagueModel(
        data: json["data"] == null ? null : LeagueData.fromJson(json["data"]),
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

class LeagueData {
  int? id;
  int? sportId;
  int? countryId;
  String? name;
  String? logo;
  bool? active;
  String? shortCode;
  String? imagePath;
  String? type;
  String? subType;
  DateTime? lastPlayedAt;
  int? category;
  bool? hasJerseys;

  LeagueData({
    this.id,
    this.sportId,
    this.countryId,
    this.name,
    this.active,
    this.shortCode,
    this.logo,
    this.imagePath,
    this.type,
    this.subType,
    this.lastPlayedAt,
    this.category,
    this.hasJerseys,
  });

  factory LeagueData.fromJson(Map<String, dynamic> json) => LeagueData(
        id: int.parse(json["id"].toString()),
        sportId: json["sport_id"],
        countryId: json["country_id"],
        name: json["name"],
        active: json["active"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        logo: json["logo"],
        type: json["type"],
        subType: json["sub_type"],
        lastPlayedAt: json["last_played_at"] == null ? null : DateTime.parse(json["last_played_at"]),
        category: json["category"],
        hasJerseys: json["has_jerseys"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "name": name,
        "active": active,
        "short_code": shortCode,
        "logo": logo,
        "image_path": imagePath,
        "type": type,
        "sub_type": subType,
        "last_played_at": lastPlayedAt?.toIso8601String(),
        "category": category,
        "has_jerseys": hasJerseys,
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
