import 'package:sportk/utils/enums.dart';

class NewModel {
  bool? status;
  int? code;
  String? msg;
  List<NewData>? data;

  NewModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<NewData>.from(json["data"]!.map((x) => NewData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NewData {
  int? id;
  String? title;
  String? content;
  String? image;
  String? sourceImage;
  String? link;
  String? source;
  String? publicationTime;
  List<Tag>? tags;
  int? numberOfLikes;
  int? likeType;
  bool? isLiked;

  NewData({
    this.id,
    this.title,
    this.content,
    this.image,
    this.sourceImage,
    this.link,
    this.source,
    this.publicationTime,
    this.tags,
    this.numberOfLikes,
    this.likeType,
    this.isLiked,
  });

  factory NewData.fromJson(Map<String, dynamic> json) => NewData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"] ?? '',
        link: json["link"],
        likeType: json["like_type"],
        isLiked: json["like_type"] == LikeType.like,
        source: json["source"],
        sourceImage: json["source_image"] ?? '',
        publicationTime: json["publication_time"],
        tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        numberOfLikes: json["number_of_likes"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "isLiked": isLiked,
        "content": content,
        "image": image,
        "like_type": likeType,
        "source_image": sourceImage,
        "link": link,
        "source": source,
        "publication_time": publicationTime,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "number_of_likes": numberOfLikes,
      };
}

class Tag {
  int? id;
  String? name;

  Tag({
    this.id,
    this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
