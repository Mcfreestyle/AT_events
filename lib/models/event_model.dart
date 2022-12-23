import 'dart:convert';

import 'package:flutter/foundation.dart';

class Event {
  Event({
    this.id,
    this.createdAt,
    this.name,
    this.date,
    this.place,
    this.description,
    this.imageName,
    this.price,
    this.categoryId,
    this.uint8Image,
  });

  int? id;
  DateTime? createdAt;
  String? name;
  DateTime? date;
  String? place;
  String? description;
  String? imageName;
  double? price;
  int? categoryId;
  Uint8List? uint8Image;

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        date: DateTime.parse(json["date"]),
        place: json["place"],
        description: json["description"],
        imageName: json["imageName"],
        price: json["price"].toDouble(),
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "date": date?.toIso8601String(),
        "place": place,
        "description": description,
        "imageName": imageName,
        "price": price,
        "category_id": categoryId,
        "unit8Image": uint8Image,
      };
}
