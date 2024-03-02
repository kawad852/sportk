class LeagueByDateModel {
  List<MatchData>? data;
  Pagination? pagination;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  LeagueByDateModel({
    this.data,
    this.pagination,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory LeagueByDateModel.fromJson(Map<String, dynamic> json) => LeagueByDateModel(
        data: json["data"] == null ? [] : List<MatchData>.from(json["data"]!.map((x) => MatchData.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        subscription: json["subscription"] == null ? [] : List<Subscription>.from(json["subscription"]!.map((x) => Subscription.fromJson(x))),
        rateLimit: json["rate_limit"] == null ? null : RateLimit.fromJson(json["rate_limit"]),
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "subscription": subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
      };
}

class MatchData {
  int? id;
  int? sportId;
  int? leagueId;
  int? seasonId;
  int? stageId;
  dynamic groupId;
  dynamic aggregateId;
  int? roundId;
  int? stateId;
  int? venueId;
  String? name;
  String? startingAt;
  String? resultInfo;
  String? leg;
  dynamic details;
  int? length;
  bool? placeholder;
  bool? hasOdds;
  int? startingAtTimestamp;
  List<Participant>? participants;
  List<Statistic>? statistics;

  MatchData({
    this.id,
    this.sportId,
    this.leagueId,
    this.seasonId,
    this.stageId,
    this.groupId,
    this.aggregateId,
    this.roundId,
    this.stateId,
    this.venueId,
    this.name,
    this.startingAt,
    this.resultInfo,
    this.leg,
    this.details,
    this.length,
    this.placeholder,
    this.hasOdds,
    this.startingAtTimestamp,
    this.participants,
    this.statistics,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) => MatchData(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        groupId: json["group_id"],
        aggregateId: json["aggregate_id"],
        roundId: json["round_id"],
        stateId: json["state_id"],
        venueId: json["venue_id"],
        name: json["name"],
        startingAt: json["starting_at"],
        resultInfo: json["result_info"],
        leg: json["leg"],
        details: json["details"],
        length: json["length"],
        placeholder: json["placeholder"],
        hasOdds: json["has_odds"],
        startingAtTimestamp: json["starting_at_timestamp"],
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
        statistics: json["statistics"] == null ? [] : List<Statistic>.from(json["statistics"]!.map((x) => Statistic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "season_id": seasonId,
        "stage_id": stageId,
        "group_id": groupId,
        "aggregate_id": aggregateId,
        "round_id": roundId,
        "state_id": stateId,
        "venue_id": venueId,
        "name": name,
        "starting_at": startingAt,
        "result_info": resultInfo,
        "leg": leg,
        "details": details,
        "length": length,
        "placeholder": placeholder,
        "has_odds": hasOdds,
        "starting_at_timestamp": startingAtTimestamp,
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
      };
}

class Participant {
  int? id;
  int? sportId;
  int? countryId;
  int? venueId;
  String? gender;
  String? name;
  String? shortCode;
  String? imagePath;
  int? founded;
  String? type;
  bool? placeholder;
  String? lastPlayedAt;
  ParticipantMeta? meta;

  Participant({
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
    this.meta,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        venueId: json["venue_id"],
        gender: json["gender"],
        name: json["name"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        founded: json["founded"],
        type: json["type"],
        placeholder: json["placeholder"],
        lastPlayedAt: json["last_played_at"],
        meta: json["meta"] == null ? null : ParticipantMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "venue_id": venueId,
        "gender": gender,
        "name": name,
        "short_code": shortCode,
        "image_path": imagePath,
        "founded": founded,
        "type": type,
        "placeholder": placeholder,
        "last_played_at": lastPlayedAt,
        "meta": meta?.toJson(),
      };
}

class ParticipantMeta {
  Location? location;
  bool? winner;
  int? position;

  ParticipantMeta({
    this.location,
    this.winner,
    this.position,
  });

  factory ParticipantMeta.fromJson(Map<String, dynamic> json) => ParticipantMeta(
        location: locationValues.map[json["location"]]!,
        winner: json["winner"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "location": locationValues.reverse[location],
        "winner": winner,
        "position": position,
      };
}

enum Location { AWAY, HOME }

final locationValues = EnumValues({"away": Location.AWAY, "home": Location.HOME});

class Statistic {
  int? id;
  int? fixtureId;
  int? typeId;
  int? participantId;
  Data? data;
  Location? location;
  Type? type;

  Statistic({
    this.id,
    this.fixtureId,
    this.typeId,
    this.participantId,
    this.data,
    this.location,
    this.type,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        id: json["id"],
        fixtureId: json["fixture_id"],
        typeId: json["type_id"],
        participantId: json["participant_id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        location: locationValues.map[json["location"]]!,
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "type_id": typeId,
        "participant_id": participantId,
        "data": data?.toJson(),
        "location": locationValues.reverse[location],
        "type": type?.toJson(),
      };
}

class Data {
  int? value;

  Data({
    this.value,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Type {
  int? id;
  String? name;
  String? code;
  String? developerName;
  ModelType? modelType;
  StatGroup? statGroup;

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
        modelType: modelTypeValues.map[json["model_type"]]!,
        statGroup: statGroupValues.map[json["stat_group"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "developer_name": developerName,
        "model_type": modelTypeValues.reverse[modelType],
        "stat_group": statGroupValues.reverse[statGroup],
      };
}

enum ModelType { STATISTIC }

final modelTypeValues = EnumValues({"statistic": ModelType.STATISTIC});

enum StatGroup { DEFENSIVE, OFFENSIVE, OVERALL }

final statGroupValues = EnumValues({"defensive": StatGroup.DEFENSIVE, "offensive": StatGroup.OFFENSIVE, "overall": StatGroup.OVERALL});

class Pagination {
  int? count;
  int? perPage;
  int? currentPage;
  dynamic nextPage;
  bool? hasMore;

  Pagination({
    this.count,
    this.perPage,
    this.currentPage,
    this.nextPage,
    this.hasMore,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "next_page": nextPage,
        "has_more": hasMore,
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
  SubscriptionMeta? meta;
  List<Plan>? plans;
  List<dynamic>? addOns;
  List<SubWidget>? widgets;

  Subscription({
    this.meta,
    this.plans,
    this.addOns,
    this.widgets,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        meta: json["meta"] == null ? null : SubscriptionMeta.fromJson(json["meta"]),
        plans: json["plans"] == null ? [] : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
        addOns: json["add_ons"] == null ? [] : List<dynamic>.from(json["add_ons"]!.map((x) => x)),
        widgets: json["widgets"] == null ? [] : List<SubWidget>.from(json["widgets"]!.map((x) => SubWidget.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x)),
        "widgets": widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x.toJson())),
      };
}

class SubscriptionMeta {
  String? trialEndsAt;
  String? endsAt;
  int? currentTimestamp;

  SubscriptionMeta({
    this.trialEndsAt,
    this.endsAt,
    this.currentTimestamp,
  });

  factory SubscriptionMeta.fromJson(Map<String, dynamic> json) => SubscriptionMeta(
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

class SubWidget {
  String? widget;
  String? sport;

  SubWidget({
    this.widget,
    this.sport,
  });

  factory SubWidget.fromJson(Map<String, dynamic> json) => SubWidget(
        widget: json["widget"],
        sport: json["sport"],
      );

  Map<String, dynamic> toJson() => {
        "widget": widget,
        "sport": sport,
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
