import 'package:sportk/model/comment_model.dart';

class CommentsModel {
  bool? status;
  int? code;
  String? msg;
  List<CommentData>? data;

  CommentsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<CommentData>.from(json["data"]!.map((x) => CommentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
