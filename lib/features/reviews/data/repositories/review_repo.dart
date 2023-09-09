import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:review_app/utils/methods.dart';

import '../../domain/entities/upload_review.dart';

class ReviewRepo {
  final _db = FirebaseFirestore.instance;
  static final reviewFireInstance = FirebaseFirestore.instance
                            .collection('reviews')
                            .snapshots();

  Future<bool> likeReview(int reviewId) async {

    try {
      List<String>? details = await getLoginDetails();
      int userId = -1;

      if (details != null) {
        userId = int.parse(details[0]);
      }

      final snapshot = await _db.collection('reviews').doc(reviewId.toString());
      await snapshot.update({
        'likedBy': FieldValue.arrayUnion([
          userId
        ]),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getReviews() async {
    final snapshot = await _db.collection('reviews').get();
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }

  Future<bool> uploadReview(UploadReviewModel uploadReviewModel, File imageSelected) async {

    try {
      List<Map<String, dynamic>> data = await getReviews();
      int reviewId = getMaxRId(data) + 1;

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
      String imageUrl = await _uploadFile(reviewId, imageSelected);

      uploadReviewModel.userId = userId;
      uploadReviewModel.username = username;
      uploadReviewModel.rid = reviewId;
      uploadReviewModel.date = date;
      uploadReviewModel.imageUrl = imageUrl;


      final snapshot = await _db.collection('reviews').doc(reviewId.toString());
      await snapshot.set(uploadReviewModel.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _uploadFile(int rId, File _imageFile) async {
    try {
    final Reference storageRef =
      FirebaseStorage.instance.ref().child('review_images');
      UploadTask uploadTask = storageRef.child(rId.toString()).putFile(_imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } catch (error) {
      return 'null';
    }
  }
}
