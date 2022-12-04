// To parse this JSON data, do
//
//     final candleData = candleDataFromJson(jsonString);

import 'dart:convert';

NewsData newsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

String newsDataToJson(NewsData data) => json.encode(data.toJson());

class NewsData {
  NewsData({
    this.data,
    this.totalPages,
  });

  List<Datum>? data;
  int? totalPages;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "total_pages": totalPages,
      };
}

class Datum {
  Datum({
    this.newsUrl,
    this.imageUrl,
    this.title,
    this.text,
    this.sourceName,
    this.date,
    this.topics,
    this.sentiment,
    this.type,
  });

  String? newsUrl;
  String? imageUrl;
  String? title;
  String? text;
  String? sourceName;
  String? date;
  List<String>? topics;
  String? sentiment;
  String? type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        newsUrl: json["news_url"],
        imageUrl: json["image_url"],
        title: json["title"],
        text: json["text"],
        sourceName: json["source_name"],
        date: json["date"],
        topics: List<String>.from(json["topics"].map((x) => x)),
        sentiment: json["sentiment"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "news_url": newsUrl,
        "image_url": imageUrl,
        "title": title,
        "text": text,
        "source_name": sourceName,
        "date": date,
        "topics": List<dynamic>.from(topics!.map((x) => x)),
        "sentiment": sentiment,
        "type": type,
      };
}
