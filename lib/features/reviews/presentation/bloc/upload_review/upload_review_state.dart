part of 'upload_review_bloc.dart';

@immutable
abstract class UploadReviewState {}

class UploadReviewInitial extends UploadReviewState {}

class UploadReviewLoading extends UploadReviewState {}

class UploadReviewSuccess extends UploadReviewState {}

class UploadReviewFaild extends UploadReviewState {}
