import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:review_app/utils/methods.dart';

import '../../domain/entities/upload_review.dart';

class ReviewRepo {
  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getReviews() async {
    final snapshot = await _db.collection('reviews').get();
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future<bool> uploadReview(UploadReviewModel uploadReviewModel, File imageSelected) async {

    try {
      List<Map<String, dynamic>> data = await getReviews();
      int reviewId = data.length;

      List<String>? details = await getLoginDetails();
      int userId = -1;
      String username = '';
      final DateTime now = DateTime.now();
      String date = now.toString();

      if (details != null) {
        userId = int.parse(details[0]);
        username = details[1].toString();
      }

      // Upload Image
      String imageUrl = await _uploadFile(userId, imageSelected);

      uploadReviewModel.userId = userId;
      uploadReviewModel.username = username;
      uploadReviewModel.rid = reviewId;
      uploadReviewModel.date = date;
      uploadReviewModel.imageUrl = imageUrl;


      final snapshot = await _db.collection('reviews');
      await snapshot.add(uploadReviewModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _uploadFile(int rId, File _imageFile) async {
    final Reference storageRef =
      FirebaseStorage.instance.ref().child('review_images');
    try {
      UploadTask uploadTask = storageRef.child('${rId}').putFile(_imageFile!);
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      return 'null';
    }
  }
}
