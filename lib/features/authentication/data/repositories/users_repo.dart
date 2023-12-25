import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:review_app/utils/methods.dart';

class UsersRepo {
  final _db = FirebaseFirestore.instance;
  static final userFireInstance = FirebaseFirestore.instance
                            .collection('users');

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

  Future<int> updateProfile(File? selectedImage, String name, String username, String bio) async {

    try {
      List<String>? details = await getLoginDetails();
      int userId = -1;
      String phoneNo = '';

      if (details != null) {
        userId = int.parse(details[0]);
        phoneNo = details[2];
      }

      // Upload Image
      String imageUrl = "null";
      if(selectedImage != null){
        imageUrl = await _uploadFile(userId, selectedImage);
      }

      var document = await userFireInstance
          .doc('usersdoc')
          .get();

      List<Map<String, dynamic>> usersData =
      List<Map<String, dynamic>>.from(document.data()?["userslist"] ?? []);

      for (var user in usersData) {
        if (user['uid'] == userId) {
          user['fullname'] = name;
          user['username'] = username;
          user['bio'] = bio;
          if(imageUrl != "null"){
            user['profileurl'] = imageUrl;
          }
        }
      }

      await userFireInstance.doc('usersdoc').update({
        'userslist': usersData
      });

      try {
        loginDetails(userId.toString(), username, phoneNo);
      } on Exception catch (e) {
        return -1;
      }
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> changePhoneNo(String phoneNo) async {

    try {
      List<String>? details = await getLoginDetails();
      int userId = -1;
      String username = '';
      String phoneNo = '';

      if (details != null) {
        userId = int.parse(details[0]);
        username = details[1];
        phoneNo = details[2];
      }

      var document = await userFireInstance
          .doc('usersdoc')
          .get();

      List<Map<String, dynamic>> usersData =
      List<Map<String, dynamic>>.from(document.data()?["userslist"] ?? []);

      for (var user in usersData) {
        if (user['uid'] == userId) {
          user['phoneno'] = phoneNo;
        }
      }

      await userFireInstance.doc('usersdoc').update({
        'userslist': usersData
      });

      try {
        loginDetails(userId.toString(), username, phoneNo);
      } on Exception catch (e) {
        return -1;
      }
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<String> _uploadFile(int rId, File _imageFile) async {
    try {
      final Reference storageRef =
      FirebaseStorage.instance.ref().child('users_profile');
      UploadTask uploadTask = storageRef.child(rId.toString()).putFile(_imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      return 'null';
    }
  }
}
