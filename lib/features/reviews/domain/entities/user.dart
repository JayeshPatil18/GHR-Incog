class User {
  final String bio;
  final String email;
  final String gender;
  final String profileUrl;
  final int rank;
  final int score;
  final int status;
  final int uid;
  final String username;

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
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      bio: map['bio'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      profileUrl: map['profileurl'] ?? '',
      rank: map['rank'] ?? 0,
      score: map['score'] ?? '',
      status: map['status'] ?? 0,
      uid: map['userid'] ?? 0,
      username: map['username'] ?? '',
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
    };
  }
}
