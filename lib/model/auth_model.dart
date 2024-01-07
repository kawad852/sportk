class AuthModel {
  String? id;
  String? createdAt;
  String? displayName;
  String? phone;
  String? email;
  bool? isBlocked;
  String? provider;
  List<String>? favorites;
  String? phoneCountryCode;
  String? countyCode;
  bool? isBranchSaved;

  AuthModel({
    this.id,
    this.createdAt,
    this.displayName,
    this.phone,
    this.email,
    this.provider,
    this.isBlocked,
    this.favorites,
    this.phoneCountryCode,
    this.countyCode,
    this.isBranchSaved,
  });

  factory AuthModel.copy(AuthModel data) => AuthModel.fromJson(data.toJson());

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        id: json["id"],
        createdAt: json["createdAt"],
        displayName: json["displayName"],
        phone: json["phone"],
        phoneCountryCode: json["phoneCountryCode"],
        countyCode: json["countyCode"],
        email: json["email"],
        provider: json["provider"],
        isBranchSaved: json["isBranchSaved"] ?? false,
        isBlocked: json["isBlocked"] ?? false,
        favorites: json["favorites"] == null ? [] : List<String>.from(json["favorites"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt,
        "displayName": displayName,
        "phone": phone,
        "phoneCountryCode": phoneCountryCode,
        "countyCode": countyCode,
        "email": email,
        "provider": provider,
        "isBlocked": isBlocked,
        "isBranchSaved": isBranchSaved,
        "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x)),
      };
}
