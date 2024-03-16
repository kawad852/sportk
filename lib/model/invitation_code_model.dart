class InvitationCodeModel {
    bool? status;
    int? code;
    String? msg;

    InvitationCodeModel({
        this.status,
        this.code,
        this.msg,
    });

    factory InvitationCodeModel.fromJson(Map<String, dynamic> json) => InvitationCodeModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
    };
}
