class MakeOffer {
  MakeOffer(
      {required this.title,
      required this.receiverName,
      required this.userName,
      required this.profitRate});

  final String title;
  final String receiverName;
  final String userName;
  final int profitRate;

  factory MakeOffer.fromJson(Map<String, dynamic> json) => MakeOffer(
        title: json["title"],
        receiverName: json["receiverName"],
        userName: json["userName"],
        profitRate: json["profitRate"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "receiverName": receiverName,
        "userName": userName,
        "profitRate": profitRate,
      };
}
