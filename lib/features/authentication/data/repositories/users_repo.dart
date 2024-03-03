import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:review_app/main.dart';
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

  Future<int> addUser(int length, String email, String gender, String username) async {
    try {

      int profileIconListLength = MyApp.profileIconList.length;
      String profileIcon = 'null';
      if(profileIconListLength != 0){
        int randomNumber = getRandomNumber(profileIconListLength);
        profileIcon = MyApp.profileIconList[randomNumber];
      }

      String deviceId = await getUniqueDeviceId();

      final snapshot = await _db.collection('users').doc('usersdoc');

      await snapshot.update({
        'userslist': FieldValue.arrayUnion([
          {
            'userid': length,
            'profileurl': profileIcon,
            'email': email,
            'gender': gender.toLowerCase(),
            'bio': '',
            'rank': length + 1,
            'score': 0,
            'username': username,
            'status': deviceId,
          },
        ]),
      });
      return length;
    } catch (e) {
      return -1;
    }
  }

  Future<int> logoutUser(String deviceId) async {

    try {

      List<String>? details = await getLoginDetails();
      int userId = -1;

      if (details != null) {
        userId = int.parse(details[0]);
      }

      var document = await userFireInstance
          .doc('usersdoc')
          .get();

      List<Map<String, dynamic>> usersData =
      List<Map<String, dynamic>>.from(document.data()?["userslist"] ?? []);

      for (var user in usersData) {
        if (user['userid'] == userId) {
          MyApp.profileImageUrl = user['profileurl'];
          if(user['status'] != deviceId){
            return -1;
          }
        }
      }

      return 1;
    } catch (e) {
      return 0;
    }
  }


  Future<int> updateProfile(String profileUrl, String username, String bio) async {

    try {
      List<String>? details = await getLoginDetails();
      int userId = -1;

      if (details != null) {
        userId = int.parse(details[0]);
      }

      var document = await userFireInstance
          .doc('usersdoc')
          .get();

      List<Map<String, dynamic>> usersData =
      List<Map<String, dynamic>>.from(document.data()?["userslist"] ?? []);

      for (var user in usersData) {
        if (user['userid'] == userId) {
          user['username'] = username;
          user['bio'] = bio;
          user['profileurl'] = profileUrl;
        }
      }

      await userFireInstance.doc('usersdoc').update({
        'userslist': usersData
      });

      try {
        loginDetails(userId.toString(), username);
      } on Exception catch (e) {
        return -1;
      }
      MyApp.profileImageUrl = profileUrl;
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

      if (details != null) {
        userId = int.parse(details[0]);
        username = details[1];
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
        loginDetails(userId.toString(), username);
      } on Exception catch (e) {
        return -1;
      }
      return 1;
    } catch (e) {
      return 0;
    }
  }

  Future<int> changePassword(String password) async {

    try {
      List<String>? details = await getLoginDetails();
      int userId = -1;

      if (details != null) {
        userId = int.parse(details[0]);
      }

      var document = await userFireInstance
          .doc('usersdoc')
          .get();

      List<Map<String, dynamic>> usersData =
      List<Map<String, dynamic>>.from(document.data()?["userslist"] ?? []);

      for (var user in usersData) {
        if (user['uid'] == userId) {
          user['password'] = password;
        }
      }

      await userFireInstance.doc('usersdoc').update({
        'userslist': usersData
      });

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


  Future<int> validUsernameCheck(String username) async {
    UsersRepo usersRepo = UsersRepo();
    try {
      List<Map<String, dynamic>> data = await usersRepo.getUserCredentials();

      bool hasUsernameAlready = false;

      for (var userMap in data) {
        if (userMap['username'].toString().toLowerCase() == username.toLowerCase()) {
          hasUsernameAlready = true;
          break;
        }
      }
      if (!hasUsernameAlready) {
        return 1;
      } else if (hasUsernameAlready) {
        return -1;
      }
    } on Exception catch (e) {
      return 0;
    }
    return 0;
  }
}
