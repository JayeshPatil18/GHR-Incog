import 'package:firebase_database/firebase_database.dart';

class RealTimeDbService {
  final DatabaseReference _databaseReference =
  FirebaseDatabase.instance.reference();

  Future<void> fetchDownloads() async {
    try {
      DataSnapshot data =
      await _databaseReference.child('downloads').get();

      if (data.value != null) {
        print('Downloads: ${data.value}');
      } else {
        print('No data available for downloads');
      }
    } catch (error) {
      print('Error fetching downloads data: $error');
    }
  }
}
