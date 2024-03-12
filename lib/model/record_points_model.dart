class RecordPointsModel {
    bool? status;
    int? code;
    String? msg;
    List<RecordData>? data;

    RecordPointsModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory RecordPointsModel.fromJson(Map<String, dynamic> json) => RecordPointsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<RecordData>.from(json["data"]!.map((x) => RecordData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class RecordData {
    int? id;
    int? points;
    String? message;
    int? userId;
    DateTime? createdAt;

    RecordData({
        this.id,
        this.points,
        this.message,
        this.userId,
        this.createdAt,
    });

    factory RecordData.fromJson(Map<String, dynamic> json) => RecordData(
        id: json["id"],
        points: json["points"],
        message: json["message"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "points": points,
        "message": message,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
    };
}
