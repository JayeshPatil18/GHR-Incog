class User {
  final String bio;
  final String fullName;
  final String password;
  final String phoneNumber;
  final int points;
  final String profileUrl;
  final int rank;
  final int uid;
  final String username;

  User({
    required this.bio,
    required this.fullName,
    required this.password,
    required this.phoneNumber,
    required this.points,
    required this.profileUrl,
    required this.rank,
    required this.uid,
    required this.username,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      bio: map['bio'] ?? '',
      fullName: map['fullname'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneno'] ?? '',
      points: map['points'] ?? 0,
      profileUrl: map['profileurl'] ?? '',
      rank: map['rank'] ?? 0,
      uid: map['uid'] ?? 0,
      username: map['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bio': bio,
      'fullname': fullName,
      'password': password,
      'phoneno': phoneNumber,
      'points': points,
      'profileurl': profileUrl,
      'rank': rank,
      'uid': uid,
      'username': username,
    };
  }
}
