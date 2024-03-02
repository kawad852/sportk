import 'package:sportk/model/league_model.dart';

class LeagueSearchModel {
  List<LeagueData>? data;

  LeagueSearchModel({
    this.data,
  });

  factory LeagueSearchModel.fromJson(Map<String, dynamic> json) => LeagueSearchModel(
        data: json["data"] == null ? [] : List<LeagueData>.from(json["data"]!.map((x) => LeagueData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
