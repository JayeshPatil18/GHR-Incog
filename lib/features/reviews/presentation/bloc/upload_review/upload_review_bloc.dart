
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:review_app/features/reviews/data/repositories/review_repo.dart';
import 'package:review_app/features/reviews/domain/entities/upload_review.dart';
import 'package:review_app/features/reviews/presentation/bloc/upload_review/upload_review_event.dart';
import 'package:review_app/features/reviews/presentation/widgets/review_model.dart';

part 'upload_review_state.dart';

class UploadReviewBloc extends Bloc<UploadReviewEvent, UploadReviewState> {
  UploadReviewBloc() : super(UploadReviewInitial()) {
    on<UploadReviewEvent>((event, emit) async {
      if (event is UploadClickEvent) {
        emit(UploadReviewLoading());
        UploadReviewModel reviewModel = UploadReviewModel(
          brand : event.brand,
          category : event.category,
          date : '', // 
          description : event.description,
          imageUrl : '', //
          likedBy : [],
          name : event.name,
          price : event.price,
          rating : event.rating,
          summary : event.summary,
          userId : -1, //
          username : '', //
          rid: -1, //
        );

        ReviewRepo reviewRepo = ReviewRepo();
        bool isUploaded = await reviewRepo.uploadReview(reviewModel, event.imageSelected);
        if(isUploaded){
          emit(UploadReviewSuccess());
        } else{
          emit(UploadReviewFaild());
        }
      }
    });
  }
}
