import 'package:sportk/model/match_model.dart';

class SingleMatchModel {
    MatchData? data;
    List<Subscription>? subscription;
    RateLimit? rateLimit;
    String? timezone;

    SingleMatchModel({
        this.data,
        this.subscription,
        this.rateLimit,
        this.timezone,
    });

    factory SingleMatchModel.fromJson(Map<String, dynamic> json) => SingleMatchModel(
        data: json["data"] == null ? null : MatchData.fromJson(json["data"]),
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












