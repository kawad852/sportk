class HomeCompetitionsModel {
  int? code;
  bool? status;
  // List<String>? favsCompetitions;
  List<String>? competitions;

  HomeCompetitionsModel({
    this.code,
    this.status,
    // this.favsCompetitions,
    this.competitions,
  });

  factory HomeCompetitionsModel.fromJson(Map<String, dynamic> json) => HomeCompetitionsModel(
        code: json["code"],
        status: json["status"],
        // favsCompetitions: json["favs_competitions"] == null ? [] : List<String>.from(json["favs_competitions"]!.map((x) => x)),
        competitions: json["competitions"] == null ? [] : List<String>.from(json["competitions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        // "favs_competitions": favsCompetitions == null ? [] : List<dynamic>.from(favsCompetitions!.map((x) => x)),
        "competitions": competitions == null ? [] : List<dynamic>.from(competitions!.map((x) => x)),
      };
}
