class Item {
  Item({
    required this.id,
    required this.name,
    required this.value,
    required this.unit,
  });

  int id;
  String name;
  String value;
  String unit;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        value: json["value"].toString(),
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "unit": unit,
      };
}
