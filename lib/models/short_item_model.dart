import 'dart:convert';

ShortItem welcomeFromJson(String str) => ShortItem.fromJson(json.decode(str));

String welcomeToJson(ShortItem data) => json.encode(data.toJson());

class ShortItem {
  ShortItem({
    required this.id,
    required this.name,
    required this.value,
  });

  final int id;
  final String name;
  final String value;

  factory ShortItem.fromJson(Map<String, dynamic> json) => ShortItem(
        id: json["id"],
        name: json["name"],
        value: json["value"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
      };
}
