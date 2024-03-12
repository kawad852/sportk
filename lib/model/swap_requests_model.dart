class SwapRequestsModel {
    bool? status;
    int? code;
    String? msg;
    List<SwapData>? data;

    SwapRequestsModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory SwapRequestsModel.fromJson(Map<String, dynamic> json) => SwapRequestsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<SwapData>.from(json["data"]!.map((x) => SwapData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SwapData {
    int? id;
    String? status;
    int? statusType;
    DateTime? replaceTime;
    String? code;
    int? userId;
    DateTime? createdAt;
    Voucher? voucher;

    SwapData({
        this.id,
        this.status,
        this.statusType,
        this.replaceTime,
        this.code,
        this.userId,
        this.createdAt,
        this.voucher,
    });

    factory SwapData.fromJson(Map<String, dynamic> json) => SwapData(
        id: json["id"],
        status: json["status"],
        statusType: json["status_type"],
        replaceTime: json["replace_time"] == null ? null : DateTime.parse(json["replace_time"]),
        code: json["code"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        voucher: json["voucher"] == null ? null : Voucher.fromJson(json["voucher"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "status_type": statusType,
        "replace_time": replaceTime?.toIso8601String(),
        "code": code,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "voucher": voucher?.toJson(),
    };
}

class Voucher {
    int? id;
    String? title;
    String? image;
    int? points;
    int? numberOfCodes;

    Voucher({
        this.id,
        this.title,
        this.image,
        this.points,
        this.numberOfCodes,
    });

    factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        points: json["points"],
        numberOfCodes: json["number_of_codes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "points": points,
        "number_of_codes": numberOfCodes,
    };
}
