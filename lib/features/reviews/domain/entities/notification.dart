class MyNotification {
  final String message;
  final String date;
  final String msgType;
  final String postId;

  MyNotification({
    required this.message,
    required this.date,
    required this.msgType,
    required this.postId
  });

  factory MyNotification.fromMap(Map<String, dynamic> map) {
    return MyNotification(
      message: map['message'] ?? '',
      date: map['date'] ?? '',
      msgType: map['msgtype'] ?? '',
        postId: map['postid'] ?? ''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'date': date,
      'msgtype': msgType,
      'postid': postId
    };
  }
}
