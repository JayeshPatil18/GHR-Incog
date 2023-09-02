import 'dart:io';

class UploadReviewModel {
  String brand;
  String category;
  String date;
  String description;
  String imageUrl;
  List<int> likedBy;
  String name;
  String price;
  int rating;
  int rid;
  String summary;
  int userId;
  String username;

  UploadReviewModel({
    required this.brand,
    required this.category,
    required this.date,
    required this.description,
    required this.imageUrl,
    required this.likedBy,
    required this.name,
    required this.price,
    required this.rating,
    required this.rid,
    required this.summary,
    required this.userId,
    required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'category': category,
      'date': date,
      'description': description,
      'imageUrl': imageUrl,
      'likedBy': likedBy,
      'name': name,
      'price': price,
      'rating': rating,
      'rid': rid,
      'summary': summary,
      'userId': userId,
      'username': username,
    };
  }
}
