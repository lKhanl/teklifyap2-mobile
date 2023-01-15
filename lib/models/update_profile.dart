import 'dart:convert';

UpdateProfile updateProfileFromJson(String str) => UpdateProfile.fromJson(json.decode(str));

String updateProfileToJson(UpdateProfile data) => json.encode(data.toJson());

class UpdateProfile {
  UpdateProfile({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  final String name;
  final String surname;
  final String email;
  final String password;

  factory UpdateProfile.fromJson(Map<String, dynamic> json) => UpdateProfile(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
      };
}
