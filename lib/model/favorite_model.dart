class FavoriteModel {
  int? id;
  int? userId;
  String? type;
  int? favoritableId;
  int? isFavorite;

  FavoriteModel({
    this.id,
    this.userId,
    this.type,
    this.favoritableId,
    this.isFavorite,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        favoritableId: int.parse(json["favoritable_id"].toString()),
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "favoritable_id": favoritableId,
        "is_favorite": isFavorite,
      };
}
