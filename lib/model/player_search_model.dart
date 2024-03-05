import 'package:sportk/model/player_model.dart';

class PlayerSearchModel {
  List<PlayerData>? data;

  PlayerSearchModel({
    this.data,
  });

  factory PlayerSearchModel.fromJson(Map<String, dynamic> json) => PlayerSearchModel(
        data: json["data"] == null ? [] : List<PlayerData>.from(json["data"]!.map((x) => PlayerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
