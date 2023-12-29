import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:review_app/main.dart';

class RealTimeDbService {

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
}
