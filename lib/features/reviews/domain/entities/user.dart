import 'package:review_app/features/reviews/domain/entities/notification.dart';

class User {
  final String bio;
  final String email;
  final String gender;
  final String profileUrl;
  final int rank;
  final int score;
  final String status;
  final int uid;
  final String username;
  final List<MyNotification>? notifications;

  User({
    required this.bio,
    required this.email,
    required this.gender,
    required this.profileUrl,
    required this.rank,
    required this.score,
    required this.status,
    required this.uid,
    required this.username,
    this.notifications,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    List<dynamic>? notificationsList = map['notifications'];
    List<MyNotification>? myNotifications;

    if (notificationsList != null) {
      myNotifications = (notificationsList)
          .map((notificationMap) => MyNotification(
        message: notificationMap['message'] ?? '',
        msgType: notificationMap['msgtype'] ?? '',
        date: notificationMap['date'] ?? '',
      ))
          .toList();
    }

    return User(
      bio: map['bio'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      profileUrl: map['profileurl'] ?? '',
      rank: map['rank'] ?? 0,
      score: map['score'] ?? '',
      status: map['status'] ?? '',
      uid: map['userid'] ?? 0,
      username: map['username'] ?? '',
      notifications: myNotifications,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bio': bio,
      'email': email,
      'gender': gender,
      'profileurl': profileUrl,
      'rank': rank,
      'score': score,
      'status': status,
      'userid': uid,
      'username': username,
      'notifications': notifications,
    };
  }
}
