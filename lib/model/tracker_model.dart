class TrackerModel {
    bool? status;
    int? code;
    String? msg;
    TrackerData? data;

    TrackerModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory TrackerModel.fromJson(Map<String, dynamic> json) => TrackerModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : TrackerData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class TrackerData {
    String? id;
    String? trackerId;
    String? name;
    DateTime? matchTime;
    String? trackerLinkEn;
    String? trackerLinkAr;
    String? darkTrackerLinkEn;
    String? darkTrackerLinkAr;

    TrackerData({
        this.id,
        this.trackerId,
        this.name,
        this.matchTime,
        this.trackerLinkEn,
        this.trackerLinkAr,
        this.darkTrackerLinkEn,
        this.darkTrackerLinkAr,
    });

    factory TrackerData.fromJson(Map<String, dynamic> json) => TrackerData(
        id: json["id"],
        trackerId: json["tracker_id"],
        name: json["name"],
        matchTime: json["match_time"] == null ? null : DateTime.parse(json["match_time"]),
        trackerLinkEn: json["tracker_link_en"],
        trackerLinkAr: json["tracker_link_ar"],
        darkTrackerLinkEn: json["dark_tracker_link_en"],
        darkTrackerLinkAr: json["dark_tracker_link_ar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tracker_id": trackerId,
        "name": name,
        "match_time": matchTime?.toIso8601String(),
        "tracker_link_en": trackerLinkEn,
        "tracker_link_ar": trackerLinkAr,
        "dark_tracker_link_en": darkTrackerLinkEn,
        "dark_tracker_link_ar": darkTrackerLinkAr,
    };
}
