import 'package:sportk/model/team_info_model.dart';

class TeamSearchModel {
  List<TeamInfoData>? data;

  TeamSearchModel({
    this.data,
  });

  factory TeamSearchModel.fromJson(Map<String, dynamic> json) => TeamSearchModel(
        data: json["data"] == null ? [] : List<TeamInfoData>.from(json["data"]!.map((x) => TeamInfoData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
