class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
  });

  final int id;
  final String name;
  final String surname;
  late final String email;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "email": email,
  };
}
