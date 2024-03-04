class FavoriteModel {
  bool? status;
  int? code;
  String? msg;
  List<FavoriteData>? data;

  FavoriteModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<FavoriteData>.from(json["data"]!.map((x) => FavoriteData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FavoriteData {
  int? id;
  int? userId;
  String? type;
  int? favoritableId;
  int? isFavorite;
  Object? globalKey;

  FavoriteData({
    this.id,
    this.userId,
    this.type,
    this.favoritableId,
    this.isFavorite,
    this.globalKey,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) => FavoriteData(
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
