import 'dart:convert';

Success welcomeFromJson(String str) => Success.fromJson(json.decode(str));

String welcomeToJson(Success data) => json.encode(data.toJson());

class Success {
  Success({
    required this.message,
  });

  final String message;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
