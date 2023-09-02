import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryBrandsRepo {
  final _db = FirebaseFirestore.instance;

  Future<List<String>> getCategorys() async {
    final snapshot = await _db.collection('categorys').doc('categorysdocs').get();
    final categorysData =
        List<String>.from(snapshot.data()?['categoryslist'] ?? []);
    return categorysData;
  }

  Future<List<String>> getBrands() async {
    final snapshot = await _db.collection('brands').doc('brandsdocs').get();
    final brandsData =
        List<String>.from(snapshot.data()?['brandslist'] ?? []);
    return brandsData;
  }
}
