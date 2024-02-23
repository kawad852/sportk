class SquadsModel {
    List<Datum>? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    SquadsModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory SquadsModel.fromJson(Map<String, dynamic> json) => SquadsModel(
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
    int? id;
    int? transferId;
    int? playerId;
    int? teamId;
    int? positionId;
    int? detailedPositionId;
    DateTime? start;
    DateTime? end;
    bool? captain;
    int? jerseyNumber;
    Player? player;

    Datum({
        this.id,
        this.transferId,
        this.playerId,
        this.teamId,
        this.positionId,
        this.detailedPositionId,
        this.start,
        this.end,
        this.captain,
        this.jerseyNumber,
        this.player,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        transferId: json["transfer_id"],
        playerId: json["player_id"],
        teamId: json["team_id"],
        positionId: json["position_id"],
        detailedPositionId: json["detailed_position_id"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        captain: json["captain"],
        jerseyNumber: json["jersey_number"],
        player: json["player"] == null ? null : Player.fromJson(json["player"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transfer_id": transferId,
        "player_id": playerId,
        "team_id": teamId,
        "position_id": positionId,
        "detailed_position_id": detailedPositionId,
        "start": "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "end": "${end!.year.toString().padLeft(4, '0')}-${end!.month.toString().padLeft(2, '0')}-${end!.day.toString().padLeft(2, '0')}",
        "captain": captain,
        "jersey_number": jerseyNumber,
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


