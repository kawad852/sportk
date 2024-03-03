import 'package:sportk/model/team_info_model.dart';

class TeamsBySeasonModel {
  List<TeamInfoData>? data;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  TeamsBySeasonModel({
    this.data,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory TeamsBySeasonModel.fromJson(Map<String, dynamic> json) => TeamsBySeasonModel(
        data: json["data"] == null ? [] : List<TeamInfoData>.from(json["data"]!.map((x) => TeamInfoData.fromJson(x))),
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

class TeamBySeasonData {
  int? id;
  int? sportId;
  int? countryId;
  int? venueId;
  String? gender;
  String? name;
  String? logo;
  String? shortCode;
  String? imagePath;
  int? founded;
  String? type;
  bool? placeholder;
  String? lastPlayedAt;

  TeamBySeasonData({
    this.id,
    this.sportId,
    this.countryId,
    this.venueId,
    this.gender,
    this.name,
    this.shortCode,
    this.imagePath,
    this.founded,
    this.type,
    this.placeholder,
    this.lastPlayedAt,
    this.logo,
  });

  factory TeamBySeasonData.fromJson(Map<String, dynamic> json) => TeamBySeasonData(
        id: int.parse(json["id"].toString()),
        sportId: json["sport_id"],
        countryId: json["country_id"],
        venueId: json["venue_id"],
        gender: json["gender"],
        logo: json["logo"],
        name: json["name"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        founded: json["founded"],
        type: json["type"],
        placeholder: json["placeholder"],
        lastPlayedAt: json["last_played_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "venue_id": venueId,
        "gender": gender,
        "name": name,
        "logo": logo,
        "short_code": shortCode,
        "image_path": imagePath,
        "founded": founded,
        "type": type,
        "placeholder": placeholder,
        "last_played_at": lastPlayedAt,
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
  List<dynamic>? addOns;
  List<TeamsWidget>? widgets;

  Subscription({
    this.meta,
    this.plans,
    this.addOns,
    this.widgets,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        plans: json["plans"] == null ? [] : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        addOns: json["add_ons"] == null ? [] : List<dynamic>.from(json["add_ons"]!.map((x) => x)),
        widgets: json["widgets"] == null ? [] : List<TeamsWidget>.from(json["widgets"]!.map((x) => TeamsWidget.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x)),
        "widgets": widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x.toJson())),
      };
}

class Meta {
  String? trialEndsAt;
  String? endsAt;
  int? currentTimestamp;

  Meta({
    this.trialEndsAt,
    this.endsAt,
    this.currentTimestamp,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        trialEndsAt: json["trial_ends_at"],
        endsAt: json["ends_at"],
        currentTimestamp: json["current_timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "trial_ends_at": trialEndsAt,
        "ends_at": endsAt,
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

class TeamsWidget {
  String? widget;
  String? sport;

  TeamsWidget({
    this.widget,
    this.sport,
  });

  factory TeamsWidget.fromJson(Map<String, dynamic> json) => TeamsWidget(
        widget: json["widget"],
        sport: json["sport"],
      );

  Map<String, dynamic> toJson() => {
        "widget": widget,
        "sport": sport,
      };
}
