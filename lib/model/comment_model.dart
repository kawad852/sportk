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
  int? likeType;
  int? numberOfLikes;
  User? user;
  List<CommentData>? replies;

  CommentData({
    this.id,
    this.comment,
    this.blogId,
    this.likeType,
    this.numberOfLikes,
    this.user,
    this.replies,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"],
        comment: json["comment"],
        blogId: json["blog_id"],
        likeType: json["like_type"],
        numberOfLikes: json["number_of_likes"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        replies: json["replies"] == null ? [] : List<CommentData>.from(json["replies"]!.map((x) => CommentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "blog_id": blogId,
        "like_type": likeType,
        "number_of_likes": numberOfLikes,
        "user": user?.toJson(),
        "replies": replies == null ? [] : List<dynamic>.from(replies!.map((x) => x.toJson())),
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
