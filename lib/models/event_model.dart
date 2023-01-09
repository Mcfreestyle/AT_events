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
    this.attendance,
    this.interested,
    this.categoryId,
    required this.userId,
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
  int? attendance;
  int? interested;
  int? categoryId;
  String userId;
  Uint8List? uint8Image;

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  //This is used when we want to convert the response of API(json)
  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        date: DateTime.parse(json["date"]),
        place: json["place"],
        description: json["description"],
        imageName: json["imageName"],
        price: json["price"].toDouble(),
        attendance: json["attendance"],
        interested: json["interested"],
        categoryId: json["category_id"],
        userId: json["user_id"],
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
        "attendance": attendance,
        "interested": interested,
        "category_id": categoryId,
        "unit8Image": uint8Image,
      };

  Event copyWith() {
    return Event(
      id: id,
      createdAt: createdAt,
      name: name,
      date: date,
      place: place,
      description: description,
      imageName: imageName,
      price: price,
      attendance: attendance,
      interested: interested,
      categoryId: categoryId,
      userId: userId,
      uint8Image: uint8Image,
    );
  }

  @override
  toString() {
    return ('$name-$date');
  }
}
