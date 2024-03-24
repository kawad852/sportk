import 'package:sportk/model/match_model.dart';

class LatestMatchTeamModel {
    LatestMatchData? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    LatestMatchTeamModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory LatestMatchTeamModel.fromJson(Map<String, dynamic> json) => LatestMatchTeamModel(
        data: json["data"] == null ? null : LatestMatchData.fromJson(json["data"]),
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

class LatestMatchData {
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
    List<Latest>? latest;

    LatestMatchData({
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
        this.latest,
    });

    factory LatestMatchData.fromJson(Map<String, dynamic> json) => LatestMatchData(
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
        latest: json["latest"] == null ? [] : List<Latest>.from(json["latest"]!.map((x) => Latest.fromJson(x))),
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
        "latest": latest == null ? [] : List<dynamic>.from(latest!.map((x) => x.toJson())),
    };
}

class Latest {
    int? id;
    int? sportId;
    int? leagueId;
    int? seasonId;
    int? stageId;
    int? groupId;
    int? aggregateId;
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
    LatestMeta? meta;

    Latest({
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
        this.meta,
    });

    factory Latest.fromJson(Map<String, dynamic> json) => Latest(
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
        meta: json["meta"] == null ? null : LatestMeta.fromJson(json["meta"]),
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
        "meta": meta?.toJson(),
    };
}



class LatestMeta {
    String? location;

    LatestMeta({
        this.location,
    });

    factory LatestMeta.fromJson(Map<String, dynamic> json) => LatestMeta(
        location:json["location"],
    );

    Map<String, dynamic> toJson() => {
        "location": location,
    };
}




