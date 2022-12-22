import 'dart:convert';

class Category {
  Category({
    this.id,
    this.createdAt,
    this.name,
  });

  int? id;
  DateTime? createdAt;
  String? name;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
      };
}
