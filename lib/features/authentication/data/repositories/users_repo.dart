import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:review_app/utils/methods.dart';

class UsersRepo {
  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getUserCredentials() async {
    final snapshot = await _db.collection('users').doc('usersdoc').get();
    final userData =
        List<Map<String, dynamic>>.from(snapshot.data()?['userslist'] ?? []);
    return userData;
  }

  Future<int> addUser(String fullName, String username, String phoneNo, String password) async {
    try {
      List<Map<String, dynamic>> data = await getUserCredentials();
      int length = getMaxUId(data) + 1;

      final snapshot = await _db.collection('users').doc('usersdoc');
      await snapshot.update({
        'userslist': FieldValue.arrayUnion([
          {
            'uid': length,
            'profileurl': 'null',
            'password': password,
            'bio': '',
            'rank': length,
            'fullname': fullName,
            'phoneno': phoneNo,
            'points': 0,
            'username': username,
          },
        ]),
      });
      return length;
    } catch (e) {
      return -1;
    }
  }
}
