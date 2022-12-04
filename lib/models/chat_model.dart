import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel chatsResponseFromJson(String str) =>
    ChatModel.fromJson(json.decode(str));

String chatsResponseToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({this.message, this.sendingTime, this.uid, this.name});

  String? message;
  Timestamp? sendingTime;
  String? uid;
  String? name;

  Map<String, dynamic> toJson() => {
        "message": message,
        "sending_time": sendingTime,
        "uid": uid,
        "name": name,
      };
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        message: json["message"] ?? "",
        sendingTime: json["sending_time"],
        uid: json["uid"] ?? "",
        name: json["name"] ?? "",
      );
}
