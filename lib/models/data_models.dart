// To parse this JSON data, do
//
//     final candleData = candleDataFromJson(jsonString);

import 'dart:convert';

CandleData candleDataFromJson(String str) =>
    CandleData.fromJson(json.decode(str));

String candleDataToJson(CandleData data) => json.encode(data.toJson());

class CandleData {
  CandleData({
    this.status,
    this.code,
    this.msg,
    this.response,
    this.info,
  });

  bool? status;
  int? code;
  String? msg;
  List<Response>? response;
  Info? info;

  factory CandleData.fromJson(Map<String, dynamic> json) => CandleData(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
        info: Info.fromJson(json["info"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "response": List<dynamic>.from(response!.map((x) => x.toJson())),
        "info": info!.toJson(),
      };
}

class Info {
  Info({
    required this.serverTime,
    required this.creditCount,
  });

  String serverTime;
  int creditCount;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        serverTime: json["server_time"],
        creditCount: json["credit_count"],
      );

  Map<String, dynamic> toJson() => {
        "server_time": serverTime,
        "credit_count": creditCount,
      };
}

class Response {
  Response({
    required this.id,
    required this.o,
    required this.h,
    required this.l,
    required this.c,
    required this.ch,
    required this.cp,
    required this.t,
    required this.s,
    required this.tm,
  });

  String id;
  String o;
  String h;
  String l;
  String c;
  String ch;
  String cp;
  String t;
  String s;
  DateTime tm;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["id"],
        o: json["o"],
        h: json["h"],
        l: json["l"],
        c: json["c"],
        ch: json["ch"],
        cp: json["cp"],
        t: json["t"],
        s: json["s"],
        tm: DateTime.parse(json["tm"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "o": o,
        "h": h,
        "l": l,
        "c": c,
        "ch": ch,
        "cp": cp,
        "t": t,
        "s": s,
        "tm": tm.toIso8601String(),
      };
}
