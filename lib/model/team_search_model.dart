import 'package:sportk/model/team_info_model.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/shared_pref.dart';

class TeamSearchModel {
  List<TeamInfoData>? data;

  TeamSearchModel({
    this.data,
  });

  factory TeamSearchModel.fromJson(Map<String, dynamic> json) {
    final jsonKey = MySharedPreferences.language == LanguageEnum.arabic ? json["teams"] : json["data"];
    return TeamSearchModel(
      data: jsonKey == null ? [] : List<TeamInfoData>.from(jsonKey!.map((x) => TeamInfoData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
