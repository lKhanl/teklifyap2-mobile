class MakeOfferItem {
  MakeOfferItem({
    required this.id,
    this.name,
    this.value,
    required this.quantity,
  });

  final int id;
  final String? name;
  final double? value;
  final int quantity;

  factory MakeOfferItem.fromJson(Map<String, dynamic> json) => MakeOfferItem(
        id: json["id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity.toString(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakeOfferItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
