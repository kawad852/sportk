class PointsModel {
    bool? status;
    int? code;
    String? msg;
    List<PointsData>? data;

    PointsModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory PointsModel.fromJson(Map<String, dynamic> json) => PointsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<PointsData>.from(json["data"]!.map((x) => PointsData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PointsData {
    int? id;
    String? key;
    String? value;

    PointsData({
        this.id,
        this.key,
        this.value,
    });

    factory PointsData.fromJson(Map<String, dynamic> json) => PointsData(
        id: json["id"],
        key: json["key"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
    };
}
