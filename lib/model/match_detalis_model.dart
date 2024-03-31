import 'package:sportk/model/match_model.dart';

class MatchDetalisModel {
  DetalisData? data;
  List<Subscription>? subscription;
  RateLimit? rateLimit;
  String? timezone;

  MatchDetalisModel({
    this.data,
    this.subscription,
    this.rateLimit,
    this.timezone,
  });

  factory MatchDetalisModel.fromJson(Map<String, dynamic> json) => MatchDetalisModel(
        data: json["data"] == null ? null : DetalisData.fromJson(json["data"]),
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

class DetalisData {
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
  DateTime? startingAt;
  String? resultInfo;
  String? leg;
  dynamic details;
  int? length;
  bool? placeholder;
  bool? hasOdds;
  int? startingAtTimestamp;
  League? league;
  Venue? venue;
  Round? stage;
  Round? round;

  DetalisData({
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
    this.league,
    this.venue,
    this.stage,
    this.round,
  });

  factory DetalisData.fromJson(Map<String, dynamic> json) => DetalisData(
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
        league: json["league"] == null ? null : League.fromJson(json["league"]),
        venue: json["venue"] == null ? null : Venue.fromJson(json["venue"]),
        stage: json["stage"] == null ? null : Round.fromJson(json["stage"]),
        round: json["round"] == null ? null : Round.fromJson(json["round"]),
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
        "league": league?.toJson(),
        "venue": venue?.toJson(),
        "stage": stage?.toJson(),
        "round": round?.toJson(),
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
  DateTime? lastPlayedAt;
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
        lastPlayedAt:
            json["last_played_at"] == null ? null : DateTime.parse(json["last_played_at"]),
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
        "last_played_at": lastPlayedAt?.toIso8601String(),
        "category": category,
        "has_jerseys": hasJerseys,
      };
}

class Round {
  int? id;
  int? sportId;
  int? leagueId;
  int? seasonId;
  int? stageId;
  String? name;
  bool? finished;
  bool? isCurrent;
  DateTime? startingAt;
  DateTime? endingAt;
  bool? gamesInCurrentWeek;
  int? typeId;
  int? sortOrder;
  dynamic tieBreakerRuleId;

  Round({
    this.id,
    this.sportId,
    this.leagueId,
    this.seasonId,
    this.stageId,
    this.name,
    this.finished,
    this.isCurrent,
    this.startingAt,
    this.endingAt,
    this.gamesInCurrentWeek,
    this.typeId,
    this.sortOrder,
    this.tieBreakerRuleId,
  });

  factory Round.fromJson(Map<String, dynamic> json) => Round(
        id: json["id"],
        sportId: json["sport_id"],
        leagueId: json["league_id"],
        seasonId: json["season_id"],
        stageId: json["stage_id"],
        name: json["name"],
        finished: json["finished"],
        isCurrent: json["is_current"],
        startingAt: json["starting_at"] == null ? null : DateTime.parse(json["starting_at"]),
        endingAt: json["ending_at"] == null ? null : DateTime.parse(json["ending_at"]),
        gamesInCurrentWeek: json["games_in_current_week"],
        typeId: json["type_id"],
        sortOrder: json["sort_order"],
        tieBreakerRuleId: json["tie_breaker_rule_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "league_id": leagueId,
        "season_id": seasonId,
        "stage_id": stageId,
        "name": name,
        "finished": finished,
        "is_current": isCurrent,
        "starting_at":
            "${startingAt!.year.toString().padLeft(4, '0')}-${startingAt!.month.toString().padLeft(2, '0')}-${startingAt!.day.toString().padLeft(2, '0')}",
        "ending_at":
            "${endingAt!.year.toString().padLeft(4, '0')}-${endingAt!.month.toString().padLeft(2, '0')}-${endingAt!.day.toString().padLeft(2, '0')}",
        "games_in_current_week": gamesInCurrentWeek,
        "type_id": typeId,
        "sort_order": sortOrder,
        "tie_breaker_rule_id": tieBreakerRuleId,
      };
}

class Venue {
  int? id;
  int? countryId;
  int? cityId;
  String? name;
  String? address;
  dynamic zipcode;
  String? latitude;
  String? longitude;
  int? capacity;
  String? imagePath;
  String? cityName;
  String? surface;
  bool? nationalTeam;

  Venue({
    this.id,
    this.countryId,
    this.cityId,
    this.name,
    this.address,
    this.zipcode,
    this.latitude,
    this.longitude,
    this.capacity,
    this.imagePath,
    this.cityName,
    this.surface,
    this.nationalTeam,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        countryId: json["country_id"],
        cityId: json["city_id"],
        name: json["name"],
        address: json["address"],
        zipcode: json["zipcode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        capacity: json["capacity"],
        imagePath: json["image_path"],
        cityName: json["city_name"],
        surface: json["surface"],
        nationalTeam: json["national_team"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "city_id": cityId,
        "name": name,
        "address": address,
        "zipcode": zipcode,
        "latitude": latitude,
        "longitude": longitude,
        "capacity": capacity,
        "image_path": imagePath,
        "city_name": cityName,
        "surface": surface,
        "national_team": nationalTeam,
      };
}
