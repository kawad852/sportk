import 'package:sportk/model/match_model.dart';

class SingleMatchEventModel {
    MatchEventData? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    SingleMatchEventModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory SingleMatchEventModel.fromJson(Map<String, dynamic> json) => SingleMatchEventModel(
        data: json["data"] == null ? null : MatchEventData.fromJson(json["data"]),
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

class MatchEventData {
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
    List<Period>? periods;
    List<Participant>? participants;

    MatchEventData({
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
        this.periods,
        this.participants,
    });

    factory MatchEventData.fromJson(Map<String, dynamic> json) => MatchEventData(
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
        periods: json["periods"] == null ? [] : List<Period>.from(json["periods"]!.map((x) => Period.fromJson(x))),
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
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
        "periods": periods == null ? [] : List<dynamic>.from(periods!.map((x) => x.toJson())),
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
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
    int? minutes;
    int? seconds;
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
    int? extraMinute;
    bool? injured;
    bool? onBench;
    dynamic coachId;
    int? subTypeId;
    Type? type;
    Player? player;

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
        this.type,
        this.player,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        fixtureId: json["fixture_id"],
        periodId: json["period_id"],
        participantId: json["participant_id"],
        typeId: json["type_id"],
        section:json["section"],
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
        type: json["type"] == null ? null : Type.fromJson(json["type"]),
        player: json["player"] == null ? null : Player.fromJson(json["player"]),
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
        "type": type?.toJson(),
        "player": player?.toJson(),
    };
}

class Player {
    int? id;
    int? sportId;
    int? countryId;
    int? nationalityId;
    int? cityId;
    int? positionId;
    int? detailedPositionId;
    int? typeId;
    String? commonName;
    String? firstname;
    String? lastname;
    String? name;
    String? displayName;
    String? imagePath;
    int? height;
    int? weight;
    DateTime? dateOfBirth;
    String? gender;

    Player({
        this.id,
        this.sportId,
        this.countryId,
        this.nationalityId,
        this.cityId,
        this.positionId,
        this.detailedPositionId,
        this.typeId,
        this.commonName,
        this.firstname,
        this.lastname,
        this.name,
        this.displayName,
        this.imagePath,
        this.height,
        this.weight,
        this.dateOfBirth,
        this.gender,
    });

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        nationalityId: json["nationality_id"],
        cityId: json["city_id"],
        positionId: json["position_id"],
        detailedPositionId: json["detailed_position_id"],
        typeId: json["type_id"],
        commonName: json["common_name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        name: json["name"],
        displayName: json["display_name"],
        imagePath: json["image_path"],
        height: json["height"],
        weight: json["weight"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        gender:json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "country_id": countryId,
        "nationality_id": nationalityId,
        "city_id": cityId,
        "position_id": positionId,
        "detailed_position_id": detailedPositionId,
        "type_id": typeId,
        "common_name": commonName,
        "firstname": firstname,
        "lastname": lastname,
        "name": name,
        "display_name": displayName,
        "image_path": imagePath,
        "height": height,
        "weight": weight,
        "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
    };
}



class Type {
    int? id;
    String? name;
    String? code;
    String? developerName;
    String? modelType;
    dynamic statGroup;

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











