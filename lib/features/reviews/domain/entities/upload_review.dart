import 'dart:io';

class UploadReviewModel {
  String date;
  List<int> likedBy;
  String mediaUrl;
  String parentId;
  String postId;
  String text;
  int userId;
  String username;

  UploadReviewModel({
    required this.date,
    required this.likedBy,
    required this.mediaUrl,
    required this.parentId,
    required this.postId,
    required this.text,
    required this.userId,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'likedby': likedBy,
      'mediaurl': mediaUrl,
      'parentid': parentId,
      'postid': postId,
      'text': text,
      'userid': userId,
      'username': username,
    };
  }

   factory UploadReviewModel.fromMap(Map<String, dynamic> map) {
    return UploadReviewModel(
      date: map['date'] ?? '',
      likedBy: (map['likedby'] as List<dynamic>).map<int>((item) => item as int).toList(),
      mediaUrl: map['mediaurl'] ?? '',
      parentId: map['parentid'] ?? '',
      postId: map['postid'] ?? '',
      text: map['text'] ?? 0,
      userId: map['userid'] ?? 0,
      username: map['username'] ?? '',
    );
  }
}
