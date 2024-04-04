import 'package:sportk/model/league_model.dart';
import 'package:sportk/utils/enums.dart';
import 'package:sportk/utils/shared_pref.dart';

class LeagueSearchModel {
  List<LeagueData>? data;

  LeagueSearchModel({
    this.data,
  });

  factory LeagueSearchModel.fromJson(Map<String, dynamic> json) {
    final jsonKey = MySharedPreferences.language == LanguageEnum.arabic ? json["competitions"] : json["data"];
    return LeagueSearchModel(
      data: jsonKey == null ? [] : List<LeagueData>.from(jsonKey!.map((x) => LeagueData.fromJson(x))),
    );
  }
}
