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
  String? link;
  String? source;
  String? publicationTime;
  List<Tag>? tags;
  bool? isLiked;
  int? numberOfLikes;

  NewData({
    this.id,
    this.title,
    this.content,
    this.image,
    this.link,
    this.source,
    this.publicationTime,
    this.tags,
    this.isLiked,
    this.numberOfLikes,
  });

  factory NewData.fromJson(Map<String, dynamic> json) => NewData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        link: json["link"],
        source: json["source"],
        publicationTime: json["publication_time"],
        tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        isLiked: json["is_liked"],
        numberOfLikes: json["number_of_likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "image": image,
        "link": link,
        "source": source,
        "publication_time": publicationTime,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "is_liked": isLiked,
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
