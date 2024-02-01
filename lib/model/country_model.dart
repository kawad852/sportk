class CyModel {
    int? code;
    List<Result>? results;

    CyModel({
        this.code,
        this.results,
    });

    factory CyModel.fromJson(Map<String, dynamic> json) => CyModel(
        code: json["code"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Result {
    String? id;
    String? categoryId;
    String? name;
    String? logo;
    int? updatedAt;

    Result({
        this.id,
        this.categoryId,
        this.name,
        this.logo,
        this.updatedAt,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        logo: json["logo"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "logo": logo,
        "updated_at": updatedAt,
    };
}
