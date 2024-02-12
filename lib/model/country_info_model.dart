class CountryInfoModel {
    Data? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    CountryInfoModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory CountryInfoModel.fromJson(Map<String, dynamic> json) => CountryInfoModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data {
    int? id;
    int? continentId;
    String? name;
    String? officialName;
    String? fifaName;
    String? iso2;
    String? iso3;
    String? latitude;
    String? longitude;
    List<String>? borders;
    String? imagePath;

    Data({
        this.id,
        this.continentId,
        this.name,
        this.officialName,
        this.fifaName,
        this.iso2,
        this.iso3,
        this.latitude,
        this.longitude,
        this.borders,
        this.imagePath,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        continentId: json["continent_id"],
        name: json["name"],
        officialName: json["official_name"],
        fifaName: json["fifa_name"],
        iso2: json["iso2"],
        iso3: json["iso3"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        borders: json["borders"] == null ? [] : List<String>.from(json["borders"]!.map((x) => x)),
        imagePath: json["image_path"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "continent_id": continentId,
        "name": name,
        "official_name": officialName,
        "fifa_name": fifaName,
        "iso2": iso2,
        "iso3": iso3,
        "latitude": latitude,
        "longitude": longitude,
        "borders": borders == null ? [] : List<dynamic>.from(borders!.map((x) => x)),
        "image_path": imagePath,
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
