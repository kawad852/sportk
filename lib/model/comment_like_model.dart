class CommentLikeModel {
  bool? status;
  int? code;
  String? msg;
  int? like;

  CommentLikeModel({
    this.status,
    this.code,
    this.msg,
    this.like,
  });

  factory CommentLikeModel.fromJson(Map<String, dynamic> json) => CommentLikeModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "like": like,
      };
}
