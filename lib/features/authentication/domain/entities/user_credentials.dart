
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCredentials {
  final String username;
  final String password;

  UserCredentials({
    required this.username,
    required this.password
  });


  factory UserCredentials.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data();
    return UserCredentials(username: data!['username'], password: data['password']);
  }
}