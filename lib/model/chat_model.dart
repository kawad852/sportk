import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  Timestamp? createdAt;
  String? message;
  String? photoURL;
  int? userId;

  ChatModel({
    this.createdAt,
    this.message,
    this.photoURL,
    this.userId,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        createdAt: json["createdAt"],
        message: json["message"],
        photoURL: json["photoURL"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "message": message,
        "photoURL": photoURL,
        "userId": userId,
      };
}
