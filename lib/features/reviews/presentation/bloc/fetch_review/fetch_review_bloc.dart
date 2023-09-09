import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';

import '../../../data/repositories/review_repo.dart';
import '../../../domain/entities/upload_review.dart';
import 'fetch_review_event.dart';
import 'fetch_review_state.dart';


class FetchReviewBloc extends Bloc<FetchReviewEvent, FetchReviewState> {
  FetchReviewBloc() : super(FetchReviewInitial()) {
    on<FetchReviewEvent>((event, emit) async {
      if (event is FetchReview) {
        emit(FetchLoading());
        try {
          ReviewRepo reviewRepo = ReviewRepo();
          List<Map<String, dynamic>> data = await reviewRepo.getReviews();
          List<UploadReviewModel> reviewList = data.map((map) {
  return UploadReviewModel.fromMap(map);
}).toList();
          emit(FetchSuccess(reviewList: reviewList));
        } catch (e) {
          emit(FetchFaild());
        }
      }
    });
  }
}
