// To parse this JSON data, do
//
//     final mainMatchesModel = mainMatchesModelFromJson(jsonString);

import 'dart:convert';

import 'package:sportk/model/league_by_date_model.dart';
import 'package:sportk/model/league_model.dart';

MainMatchesModel mainMatchesModelFromJson(String str) => MainMatchesModel.fromJson(json.decode(str));

String mainMatchesModelToJson(MainMatchesModel data) => json.encode(data.toJson());

class MainMatchesModel {
  List<MainMatchData>? data;
  Pagination? pagination;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  MainMatchesModel({
    this.data,
    this.pagination,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory MainMatchesModel.fromJson(Map<String, dynamic> json) => MainMatchesModel(
        data: json["data"] == null ? [] : List<MainMatchData>.from(json["data"]!.map((x) => MainMatchData.fromJson(x))),
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

class MainMatchData {
  int? id;
  int? sportId;
  int? leagueId;
  int? seasonId;
  int? stageId;
  dynamic groupId;
  dynamic aggregateId;
  dynamic roundId;
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
  MState? state;
  LeagueData? league;
  List<Period>? periods;
  List<Statistic>? statistics;

  MainMatchData({
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
    this.state,
    this.league,
    this.periods,
    this.statistics,
  });

  factory MainMatchData.fromJson(Map<String, dynamic> json) => MainMatchData(
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
        state: json["state"] == null ? null : MState.fromJson(json["state"]),
        league: json["league"] == null ? null : LeagueData.fromJson(json["league"]),
        periods: json["periods"] == null ? [] : List<Period>.from(json["periods"]!.map((x) => Period.fromJson(x))),
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
        "state": state?.toJson(),
        "league": league?.toJson(),
        "periods": periods == null ? [] : List<dynamic>.from(periods!.map((x) => x.toJson())),
        "statistics": statistics == null ? [] : List<dynamic>.from(statistics!.map((x) => x.toJson())),
      };
}

class League {
  int? id;
  int? sportId;
  int? countryId;
  String? name;
  bool? active;
  String? shortCode;
  String? imagePath;
  String? type;
  String? subType;
  String? lastPlayedAt;
  int? category;
  bool? hasJerseys;

  League({
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
  });

  factory League.fromJson(Map<String, dynamic> json) => League(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        name: json["name"],
        active: json["active"],
        shortCode: json["short_code"],
        imagePath: json["image_path"],
        type: json["type"],
        subType: json["sub_type"],
        lastPlayedAt: json["last_played_at"],
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
        "image_path": imagePath,
        "type": type,
        "sub_type": subType,
        "last_played_at": lastPlayedAt,
        "category": category,
        "has_jerseys": hasJerseys,
      };
}

class MState {
  int? id;
  String? state;
  String? name;
  String? shortName;
  String? developerName;

  MState({
    this.id,
    this.state,
    this.name,
    this.shortName,
    this.developerName,
  });

  factory MState.fromJson(Map<String, dynamic> json) => MState(
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

class Pagination {
  int? count;
  int? perPage;
  int? currentPage;
  String? nextPage;
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
  List<dynamic>? widgets;

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
        widgets: json["widgets"] == null ? [] : List<dynamic>.from(json["widgets"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "plans": plans == null ? [] : List<dynamic>.from(plans!.map((x) => x.toJson())),
        "add_ons": addOns == null ? [] : List<dynamic>.from(addOns!.map((x) => x)),
        "widgets": widgets == null ? [] : List<dynamic>.from(widgets!.map((x) => x)),
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
