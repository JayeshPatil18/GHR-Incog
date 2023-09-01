import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_credentials.dart';

class UserCredentialsRepo {

  final _db = FirebaseFirestore.instance;

  Future<UserCredentials> getUserCredentials(String username) async{
    final snapshot = await _db.collection('userauth').where('username', isEqualTo: username).get();
    final userData = snapshot.docs.map((e) => UserCredentials.fromSnapshot(e)).single;
    return userData;
  }


}
