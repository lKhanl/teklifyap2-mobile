class SuccessDataMessage<T> {
  final String timestamp;
  final List<T> data;
  final String path;

  SuccessDataMessage(
      {required this.timestamp, required this.data, required this.path});

  factory SuccessDataMessage.fromJson(Map<String, dynamic> json) {
    return SuccessDataMessage(
      timestamp: json['timestamp'],
      data: json['data'],
      path: json['path'],
    );
  }
}
