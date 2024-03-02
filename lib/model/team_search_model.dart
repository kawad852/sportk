import 'package:sportk/model/team_model.dart';

class TeamSearchModel {
  List<TeamData>? data;

  TeamSearchModel({
    this.data,
  });

  factory TeamSearchModel.fromJson(Map<String, dynamic> json) => TeamSearchModel(
        data: json["data"] == null ? [] : List<TeamData>.from(json["data"]!.map((x) => TeamData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
