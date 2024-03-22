class LeagueByDateModel {
  List<MatchData>? data;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  LeagueByDateModel({
    this.data,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory LeagueByDateModel.fromJson(Map<String, dynamic> json) => LeagueByDateModel(
        data: json["data"] == null ? [] : List<MatchData>.from(json["data"]!.map((x) => MatchData.fromJson(x))),
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

class MatchData {
  int? id;
  int? sportId;
  int? leagueId;
  int? seasonId;
  int? stageId;
  dynamic groupId;
  int? aggregateId;
  dynamic roundId;
  int? stateId;
  dynamic venueId;
  String? name;
  DateTime? startingAt;
  dynamic resultInfo;
  String? leg;
  dynamic details;
  int? length;
  bool? placeholder;
  bool? hasOdds;
  int? startingAtTimestamp;
  List<Statistic>? statistics;
  States? state;
  List<Participant>? participants;
  List<Period>? periods;

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
    this.statistics,
    this.state,
    this.participants,
    this.periods,
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
        startingAt: json["starting_at"] == null ? null : DateTime.parse(json["starting_at"]),
        resultInfo: json["result_info"],
        leg: json["leg"],
        details: json["details"],
        length: json["length"],
        placeholder: json["placeholder"],
        hasOdds: json["has_odds"],
        startingAtTimestamp: json["starting_at_timestamp"],
        statistics: json["statistics"] == null ? [] : List<Statistic>.from(json["statistics"]!.map((x) => Statistic.fromJson(x))),
        state: json["state"] == null ? null : States.fromJson(json["state"]),
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
        periods: json["periods"] == null ? [] : List<Period>.from(json["periods"]!.map((x) => Period.fromJson(x))),
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
        "starting_at": startingAt?.toIso8601String(),
        "result_info": resultInfo,
        "leg": leg,
        "details": details,
        "length": length,
        "placeholder": placeholder,
        "has_odds": hasOdds,
        "starting_at_timestamp": startingAtTimestamp,
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
        "state": state?.toJson(),
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "periods": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
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
  DateTime? lastPlayedAt;
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
        lastPlayedAt: json["last_played_at"] == null ? null : DateTime.parse(json["last_played_at"]),
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
        "last_played_at": lastPlayedAt?.toIso8601String(),
        "meta": meta?.toJson(),
      };
}

class ParticipantMeta {
  String? location;
  bool? winner;
  int? position;

  ParticipantMeta({
    this.location,
    this.winner,
    this.position,
  });

  factory ParticipantMeta.fromJson(Map<String, dynamic> json) => ParticipantMeta(
        location: json["location"],
        winner: json["winner"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "winner": winner,
        "position": position,
      };
}

class Period {
  int? id;
  int? fixtureId;
  int? typeId;
  int? started;
  int? ended;
  int? countsFrom;
  bool? ticking;
  int? sortOrder;
  String? description;
  int? timeAdded;
  int? periodLength;
  dynamic minutes;
  dynamic seconds;
  bool? hasTimer;
  List<Event>? events;

  Period({
    this.id,
    this.fixtureId,
    this.typeId,
    this.started,
    this.ended,
    this.countsFrom,
    this.ticking,
    this.sortOrder,
    this.description,
    this.timeAdded,
    this.periodLength,
    this.minutes,
    this.seconds,
    this.hasTimer,
    this.events,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json["id"],
        fixtureId: json["fixture_id"],
        typeId: json["type_id"],
        started: json["started"],
        ended: json["ended"],
        countsFrom: json["counts_from"],
        ticking: json["ticking"],
        sortOrder: json["sort_order"],
        description: json["description"],
        timeAdded: json["time_added"],
        periodLength: json["period_length"],
        minutes: json["minutes"],
        seconds: json["seconds"],
        hasTimer: json["has_timer"],
        events: json["events"] == null ? [] : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "type_id": typeId,
        "started": started,
        "ended": ended,
        "counts_from": countsFrom,
        "ticking": ticking,
        "sort_order": sortOrder,
        "description": description,
        "time_added": timeAdded,
        "period_length": periodLength,
        "minutes": minutes,
        "seconds": seconds,
        "has_timer": hasTimer,
        "events": events == null ? [] : List<dynamic>.from(events!.map((x) => x.toJson())),
      };
}

class Event {
  int? id;
  int? fixtureId;
  int? periodId;
  int? participantId;
  int? typeId;
  String? section;
  int? playerId;
  int? relatedPlayerId;
  String? playerName;
  String? relatedPlayerName;
  String? result;
  String? info;
  String? addition;
  int? minute;
  dynamic extraMinute;
  bool? injured;
  bool? onBench;
  dynamic coachId;
  int? subTypeId;

  Event({
    this.id,
    this.fixtureId,
    this.periodId,
    this.participantId,
    this.typeId,
    this.section,
    this.playerId,
    this.relatedPlayerId,
    this.playerName,
    this.relatedPlayerName,
    this.result,
    this.info,
    this.addition,
    this.minute,
    this.extraMinute,
    this.injured,
    this.onBench,
    this.coachId,
    this.subTypeId,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        fixtureId: json["fixture_id"],
        periodId: json["period_id"],
        participantId: json["participant_id"],
        typeId: json["type_id"],
        section: json["section"],
        playerId: json["player_id"],
        relatedPlayerId: json["related_player_id"],
        playerName: json["player_name"],
        relatedPlayerName: json["related_player_name"],
        result: json["result"],
        info: json["info"],
        addition: json["addition"],
        minute: json["minute"],
        extraMinute: json["extra_minute"],
        injured: json["injured"],
        onBench: json["on_bench"],
        coachId: json["coach_id"],
        subTypeId: json["sub_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "period_id": periodId,
        "participant_id": participantId,
        "type_id": typeId,
        "section": section,
        "player_id": playerId,
        "related_player_id": relatedPlayerId,
        "player_name": playerName,
        "related_player_name": relatedPlayerName,
        "result": result,
        "info": info,
        "addition": addition,
        "minute": minute,
        "extra_minute": extraMinute,
        "injured": injured,
        "on_bench": onBench,
        "coach_id": coachId,
        "sub_type_id": subTypeId,
      };
}

class States {
  int? id;
  String? state;
  String? name;
  String? shortName;
  String? developerName;

  States({
    this.id,
    this.state,
    this.name,
    this.shortName,
    this.developerName,
  });

  factory States.fromJson(Map<String, dynamic> json) => States(
        id: json["id"],
        state: json["state"],
        name: json["name"],
        shortName: json["short_name"],
        developerName: json["developer_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "name": name,
        "short_name": shortName,
        "developer_name": developerName,
      };
}

class Statistic {
  int? id;
  int? fixtureId;
  int? typeId;
  int? participantId;
  Data? data;
  String? location;

  Statistic({
    this.id,
    this.fixtureId,
    this.typeId,
    this.participantId,
    this.data,
    this.location,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
        id: json["id"],
        fixtureId: json["fixture_id"],
        typeId: json["type_id"],
        participantId: json["participant_id"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "type_id": typeId,
        "participant_id": participantId,
        "data": data?.toJson(),
        "location": location,
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
  List<AddOn>? addOns;
  List<Widgets>? widgets;

  Subscription({
    this.meta,
    this.plans,
    this.addOns,
    this.widgets,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        meta: json["meta"] == null ? null : SubscriptionMeta.fromJson(json["meta"]),
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

class SubscriptionMeta {
  DateTime? trialEndsAt;
  DateTime? endsAt;
  int? currentTimestamp;

  SubscriptionMeta({
    this.trialEndsAt,
    this.endsAt,
    this.currentTimestamp,
  });

  factory SubscriptionMeta.fromJson(Map<String, dynamic> json) => SubscriptionMeta(
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
