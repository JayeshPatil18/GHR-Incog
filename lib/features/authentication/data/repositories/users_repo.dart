import 'package:cloud_firestore/cloud_firestore.dart';
class UserCredentialsRepo {

  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getUserCredentials() async{
    final snapshot = await _db.collection('users').doc('usersdoc').get();
    final userData = List<Map<String, dynamic>>.from(snapshot.data()?['userslist'] ?? []);
    return userData;
  }
}
