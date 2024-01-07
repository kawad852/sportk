class LocaleModel {
  LocaleModel({
    this.ip,
    this.countryCode,
  });

  String? ip;
  String? countryCode;

  factory LocaleModel.fromJson(Map<String, dynamic> json) => LocaleModel(
        ip: json["ip"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "countryCode": countryCode,
      };
}
