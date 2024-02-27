import 'package:sportk/model/new_model.dart';

class NewDetailsModel {
  bool? status;
  int? code;
  String? msg;
  NewData? data;

  NewDetailsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory NewDetailsModel.fromJson(Map<String, dynamic> json) => NewDetailsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : NewData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}
