class MyNotification {
  final String message;
  final String date;
  final String msgType;

  MyNotification({
    required this.message,
    required this.date,
    required this.msgType
  });

  factory MyNotification.fromMap(Map<String, dynamic> map) {
    return MyNotification(
      message: map['message'] ?? '',
      date: map['date'] ?? '',
      msgType: map['msgtype'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'date': date,
      'msgtype': msgType
    };
  }
}
