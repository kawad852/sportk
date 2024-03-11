class VouchersModel {
    bool? status;
    int? code;
    String? msg;
    List<VouchersData>? data;

    VouchersModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory VouchersModel.fromJson(Map<String, dynamic> json) => VouchersModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<VouchersData>.from(json["data"]!.map((x) => VouchersData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class VouchersData {
    int? id;
    String? title;
    String? image;
    int? points;
    int? numberOfCodes;

    VouchersData({
        this.id,
        this.title,
        this.image,
        this.points,
        this.numberOfCodes,
    });

    factory VouchersData.fromJson(Map<String, dynamic> json) => VouchersData(
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
