class NewLikeModel {
  bool? status;
  int? code;
  String? msg;
  int? numberOfLike;

  NewLikeModel({
    this.status,
    this.code,
    this.msg,
    this.numberOfLike,
  });

  factory NewLikeModel.fromJson(Map<String, dynamic> json) => NewLikeModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        numberOfLike: json["number_of_like"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "number_of_like": numberOfLike,
      };
}
