
import 'dart:io';

import 'package:flutter/material.dart';

@immutable
abstract class UploadReviewEvent {}

class UploadClickEvent extends UploadReviewEvent {
  final File? mediaSelected;
  final String postText;
  final String parentId;

  UploadClickEvent({
    required this.mediaSelected,
    required this.postText,
    required this.parentId,
  });
}
