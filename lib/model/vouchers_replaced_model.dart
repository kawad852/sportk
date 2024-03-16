import 'package:sportk/model/swap_requests_model.dart';

class VoucherReplacedModel {
  bool? status;
  int? code;
  String? msg;
  SwapData? data;

  VoucherReplacedModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory VoucherReplacedModel.fromJson(Map<String, dynamic> json) => VoucherReplacedModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : SwapData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}
