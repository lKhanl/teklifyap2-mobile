import 'dart:convert';

ShortItem welcomeFromJson(String str) => ShortItem.fromJson(json.decode(str));

String welcomeToJson(ShortItem data) => json.encode(data.toJson());

class ShortItem {
  ShortItem({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory ShortItem.fromJson(Map<String, dynamic> json) => ShortItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
