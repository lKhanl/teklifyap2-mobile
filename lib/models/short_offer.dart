import 'dart:convert';

ShortOffer welcomeFromJson(String str) => ShortOffer.fromJson(json.decode(str));

String welcomeToJson(ShortOffer data) => json.encode(data.toJson());

class ShortOffer{

  ShortOffer({
    required this.id,
    required this.title,
    required this.status,
  });

  final int id;
  final String title;
  final bool status;

  factory ShortOffer.fromJson(Map<String, dynamic> json) => ShortOffer(
    id: json["id"],
    title: json["title"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
  };
}