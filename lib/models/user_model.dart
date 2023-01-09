import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  User({
    this.id,
    this.createdAt,
    this.userName = '',
    this.name = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.phone = '',
    this.imageName = '',
  });

  String? id;
  DateTime? createdAt;
  String userName;
  String name;
  String lastName;
  String email;
  String password;
  String phone;
  String imageName;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        userName: json['userName'],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "userName": userName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "phone": phone,
      };
}
