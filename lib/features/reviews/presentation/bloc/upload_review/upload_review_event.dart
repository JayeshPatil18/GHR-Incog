
import 'dart:io';

import 'package:flutter/material.dart';

@immutable
abstract class UploadReviewEvent {}

class UploadClickEvent extends UploadReviewEvent {
  final String brand;
  final String category;
  final String description;
  final File imageSelected;
  final String name;
  final String price;
  final int rating;
  final String summary;

  UploadClickEvent({
    required this.brand,
    required this.category,
    required this.description,
    required this.imageSelected,
    required this.name,
    required this.price,
    required this.rating,
    required this.summary,
  });
}
