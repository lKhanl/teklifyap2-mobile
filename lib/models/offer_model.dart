import 'package:teklifyap_mobil2/models/short_item_model.dart';

class Offer {
  Offer({
    required this.id,
    required this.title,
    required this.status,
    required this.userName,
    required this.receiverName,
    required this.profitRate,
    required this.items,

  });

  int id;
  String title;
  bool status;
  String userName;
  String receiverName;
  double profitRate;
  List<ShortItem> items;

  factory Offer.fromJson(Map<String, dynamic> json){
      var itemObjJson = json['items'] as List;
      List<ShortItem> _items = itemObjJson.map((itemJson) => ShortItem.fromJson(itemJson)).toList();

      return Offer(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        userName: json["userName"],
        receiverName: json["receiverName"],
        profitRate: json["profitRate"],
        items: _items,
      );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "status": status,
    "userName": userName,
    "receiverName": receiverName,
    "profitRate": profitRate,
    "items": items,

  };
}
