class NotificationModel {
  bool? status;
  int? code;
  String? msg;
  List<NotificationData>? data;

  NotificationModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationData {
  int? id;
  String? title;
  String? content;

  NotificationData({
    this.id,
    this.title,
    this.content,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
      };
}
