import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:review_app/main.dart';

class RealTimeDbService {

  Future<int> uploadFeedback(int userId, String feedback) async {
    try {

      final DateTime now = DateTime.now();
      String date = now.toString().split('.')[0];
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref('feedbacks');
      databaseReference.child('$date @$userId').set(feedback);

      return 1;
    } catch (error) {
      print('Error uploading feedback data: $error');
      return -1;
    }
  }

  Future<void> updateDownloads() async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref('downloads');
      databaseReference.set(ServerValue.increment(1));
    } catch (error) {
      print('Error fetching downloads data: $error');
    }
  }

  Future<String?> getLeaderboardValue() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('leaderboard');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value.toString();
  }

  Future<String?> getEmailAddressPattern() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref('emailpatterns');
    DatabaseEvent event = await databaseReference.once();
    return event.snapshot.value.toString();
  }
}
