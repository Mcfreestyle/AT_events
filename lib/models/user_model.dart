import 'dart:convert';

class User {
  User({
    this.id,
    this.createdAt,
    this.name,
    this.lastName,
    this.email,
    this.password,
  });

  int? id;
  DateTime? createdAt;
  String? name;
  String? lastName;
  String? email;
  String? password;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "last_name": lastName,
        "email": email,
        "password": password,
      };
}
