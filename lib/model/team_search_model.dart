import 'package:sportk/model/teams_by_season_model.dart';

class TeamSearchModel {
  List<TeamBySeasonData>? data;

  TeamSearchModel({
    this.data,
  });

  factory TeamSearchModel.fromJson(Map<String, dynamic> json) => TeamSearchModel(
        data: json["data"] == null ? [] : List<TeamBySeasonData>.from(json["data"]!.map((x) => TeamBySeasonData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
