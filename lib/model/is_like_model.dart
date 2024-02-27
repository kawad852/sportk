class IsLikeModel {
  bool? status;
  int? code;
  String? msg;
  bool? like;

  IsLikeModel({
    this.status,
    this.code,
    this.msg,
    this.like,
  });

  factory IsLikeModel.fromJson(Map<String, dynamic> json) => IsLikeModel(
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
