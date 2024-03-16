import 'package:sportk/model/favorite_model.dart';

class AddFavoriteModel {
  bool? status;
  int? code;
  String? msg;
  FavoriteData? data;

  AddFavoriteModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory AddFavoriteModel.fromJson(Map<String, dynamic> json) => AddFavoriteModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : FavoriteData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}
