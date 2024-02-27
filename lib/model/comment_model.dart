class CommentModel {
  bool? status;
  int? code;
  String? msg;
  CommentData? data;

  CommentModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : CommentData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class CommentData {
  int? id;
  String? comment;
  int? userId;
  int? blogId;

  CommentData({
    this.id,
    this.comment,
    this.userId,
    this.blogId,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"],
        comment: json["comment"],
        userId: json["user_id"],
        blogId: json["blog_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "user_id": userId,
        "blog_id": blogId,
      };
}
