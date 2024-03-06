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
  int? blogId;
  bool? isLiked;
  int? numberOfLikes;
  User? user;

  CommentData({
    this.id,
    this.comment,
    this.blogId,
    this.isLiked,
    this.numberOfLikes,
    this.user,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"],
        comment: json["comment"],
        blogId: json["blog_id"],
        isLiked: json["is_liked"] ?? false,
        numberOfLikes: json["number_of_likes"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "blog_id": blogId,
        "is_liked": isLiked,
        "number_of_likes": numberOfLikes,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? profileImg;
  String? invitationCode;
  int? points;

  User({
    this.id,
    this.name,
    this.email,
    this.profileImg,
    this.invitationCode,
    this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ?? '',
        email: json["email"],
        profileImg: json["profile_img"] ?? '',
        invitationCode: json["invitation_code"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "profile_img": profileImg,
        "invitation_code": invitationCode,
        "points": points,
      };
}
