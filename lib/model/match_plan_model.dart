import 'package:sportk/model/match_model.dart' as match_model;
import 'package:sportk/model/single_match_event_model.dart';

class MatchPlanModel {
    PlanData? data;
    List<match_model.Subscription>? subscription;
    match_model.RateLimit? rateLimit;
    String? timezone;

    MatchPlanModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory MatchPlanModel.fromJson(Map<String, dynamic> json) => MatchPlanModel(
        data: json["data"] == null ? null : PlanData.fromJson(json["data"]),
        subscription: json["subscription"] == null ? [] : List<match_model.Subscription>.from(json["subscription"]!.map((x) => match_model.Subscription.fromJson(x))),
        rateLimit: json["rate_limit"] == null ? null : match_model.RateLimit.fromJson(json["rate_limit"]),
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "subscription": subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "rate_limit": rateLimit?.toJson(),
        "timezone": timezone,
    };
}

class PlanData {
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
    List<Coach>? coaches;
    List<Formation>? formations;
    List<Lineup>? lineups;
    List<Participant>? participants;
    List<Period>? periods;

    PlanData({
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
        this.coaches,
        this.formations,
        this.lineups,
        this.participants,
        this.periods,
    });

    factory PlanData.fromJson(Map<String, dynamic> json) => PlanData(
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
        coaches: json["coaches"] == null ? [] : List<Coach>.from(json["coaches"]!.map((x) => Coach.fromJson(x))),
        formations: json["formations"] == null ? [] : List<Formation>.from(json["formations"]!.map((x) => Formation.fromJson(x))),
        lineups: json["lineups"] == null ? [] : List<Lineup>.from(json["lineups"]!.map((x) => Lineup.fromJson(x))),
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
        "coaches": coaches == null ? [] : List<dynamic>.from(coaches!.map((x) => x.toJson())),
        "formations": formations == null ? [] : List<dynamic>.from(formations!.map((x) => x.toJson())),
        "lineups": lineups == null ? [] : List<dynamic>.from(lineups!.map((x) => x.toJson())),
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "periods": periods == null ? [] : List<dynamic>.from(periods!.map((x) => x.toJson())),
    };
}

class Coach {
    int? id;
    int? playerId;
    int? sportId;
    int? countryId;
    int? nationalityId;
    int? cityId;
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
    CoachMeta? meta;
    int? positionId;
    int? detailedPositionId;
    int? typeId;

    Coach({
        this.id,
        this.playerId,
        this.sportId,
        this.countryId,
        this.nationalityId,
        this.cityId,
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
        this.meta,
        this.positionId,
        this.detailedPositionId,
        this.typeId,
    });

    factory Coach.fromJson(Map<String, dynamic> json) => Coach(
        id: json["id"],
        playerId: json["player_id"],
        sportId: json["sport_id"],
        countryId: json["country_id"],
        nationalityId: json["nationality_id"],
        cityId: json["city_id"],
        commonName: json["common_name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        name: json["name"],
        displayName: json["display_name"],
        imagePath: json["image_path"],
        height: json["height"],
        weight: json["weight"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        meta: json["meta"] == null ? null : CoachMeta.fromJson(json["meta"]),
        positionId: json["position_id"],
        detailedPositionId: json["detailed_position_id"],
        typeId: json["type_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "player_id": playerId,
        "sport_id": sportId,
        "country_id": countryId,
        "nationality_id": nationalityId,
        "city_id": cityId,
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
        "meta": meta?.toJson(),
        "position_id": positionId,
        "detailed_position_id": detailedPositionId,
        "type_id": typeId,
    };
}


class CoachMeta {
    int? fixtureId;
    int? coachId;
    int? participantId;

    CoachMeta({
        this.fixtureId,
        this.coachId,
        this.participantId,
    });

    factory CoachMeta.fromJson(Map<String, dynamic> json) => CoachMeta(
        fixtureId: json["fixture_id"],
        coachId: json["coach_id"],
        participantId: json["participant_id"],
    );

    Map<String, dynamic> toJson() => {
        "fixture_id": fixtureId,
        "coach_id": coachId,
        "participant_id": participantId,
    };
}

class Formation {
    int? id;
    int? fixtureId;
    int? participantId;
    String? formation;
    String? location;

    Formation({
        this.id,
        this.fixtureId,
        this.participantId,
        this.formation,
        this.location,
    });

    factory Formation.fromJson(Map<String, dynamic> json) => Formation(
        id: json["id"],
        fixtureId: json["fixture_id"],
        participantId: json["participant_id"],
        formation: json["formation"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fixture_id": fixtureId,
        "participant_id": participantId,
        "formation": formation,
        "location": location,
    };
}

class Lineup {
    int? id;
    int? sportId;
    int? fixtureId;
    int? playerId;
    int? teamId;
    int? positionId;
    String? formationField;
    int? typeId;
    int? formationPosition;
    String? playerName;
    int? jerseyNumber;
    Coach? player;

    Lineup({
        this.id,
        this.sportId,
        this.fixtureId,
        this.playerId,
        this.teamId,
        this.positionId,
        this.formationField,
        this.typeId,
        this.formationPosition,
        this.playerName,
        this.jerseyNumber,
        this.player,
    });

    factory Lineup.fromJson(Map<String, dynamic> json) => Lineup(
        id: json["id"],
        sportId: json["sport_id"],
        fixtureId: json["fixture_id"],
        playerId: json["player_id"],
        teamId: json["team_id"],
        positionId: json["position_id"],
        formationField: json["formation_field"],
        typeId: json["type_id"],
        formationPosition: json["formation_position"],
        playerName: json["player_name"],
        jerseyNumber: json["jersey_number"],
        player: json["player"] == null ? null : Coach.fromJson(json["player"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "sport_id": sportId,
        "fixture_id": fixtureId,
        "player_id": playerId,
        "team_id": teamId,
        "position_id": positionId,
        "formation_field": formationField,
        "type_id": typeId,
        "formation_position": formationPosition,
        "player_name": playerName,
        "jersey_number": jerseyNumber,
        "player": player?.toJson(),
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


