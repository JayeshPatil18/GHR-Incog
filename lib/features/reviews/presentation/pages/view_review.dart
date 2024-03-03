import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/data/repositories/review_repo.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/utils/fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/icon_size.dart';
import '../../../../constants/values.dart';
import '../../../../main.dart';
import '../../domain/entities/id_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../widgets/circle_button.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/loginRequiredBottomSheet.dart';

class ViewReview extends StatefulWidget {
  final int reviewId;

  const ViewReview({super.key, required this.reviewId});

  @override
  State<ViewReview> createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {

  LoginRequiredState loginRequiredObj = LoginRequiredState();

  ScrollController _scrollController = ScrollController();
  bool lastStatus = true;
  double height = 385;

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        body: SafeArea(
          child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream: ReviewRepo.reviewFireInstance
                          .where('rid', isEqualTo: widget.reviewId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        final documents = snapshot.data?.docs;
                        UploadReviewModel? review;

                        if (documents != null && documents.isNotEmpty) {
                          final firstDocument = documents[0];
                          review = UploadReviewModel.fromMap(
                              firstDocument.data() as Map<String, dynamic>);
                        }

                        return SliverAppBar(
                          elevation: 0.0,
                          automaticallyImplyLeading: false,
                          pinned: false,
                          floating: true,
                          expandedHeight: height,
                          backgroundColor: AppColors.backgroundColor60,
                          flexibleSpace: FlexibleSpaceBar(
                            title: _isShrink
                                ? PreferredSize(
                                    preferredSize: Size.fromHeight(70),
                                    child: SafeArea(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 20,
                                            bottom: 20),
                                        child: Text('Review',
                                            style: MainFonts.pageTitleText()),
                                      ),
                                    ))
                                : const SizedBox(),
                            background: Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(Icons.arrow_back_ios,
                                            color: AppColors.textColor,
                                            size: 26),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if(MyApp.userId == -1){
                                            loginRequiredObj.showLoginRequiredDialog(context);
                                          } else{
                                            // ReviewRepo reviewRepo = ReviewRepo();
                                            // reviewRepo.likeReview(widget.reviewId, (review?.likedBy ?? []).contains(MyApp.userId));
                                          }
                                        },
                                        child: Container(
                                          child: (review?.likedBy ?? []).contains(MyApp.userId) ? CircleIconContainer(
                                            containerColor:
                                            AppColors.backgroundColor60,
                                            containerSize: 44,
                                            icon: Icon(Icons.favorite,
                                                color: AppColors.heartColor,
                                                size: 28),
                                          ) : CircleIconContainer(
                                            containerColor:
                                            AppColors.backgroundColor60,
                                            containerSize: 44,
                                            icon: Icon(Icons.favorite_border,
                                                color: AppColors.primaryColor30,
                                                size: 28),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 14),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: ContainerShadow.boxShadow,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppBoarderRadius
                                                .reviewUploadRadius),
                                        child: review?.mediaUrl == 'null'
                                            ? SizedBox(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width) -
                                              110,
                                          height: (MediaQuery.of(context)
                                              .size
                                              .width) -
                                              110,
                                          child: Shimmer.fromColors(
                                            baseColor: Color(0xFFe4e4e4),
                                            highlightColor: Color(0xFFCDCDCD),
                                            child: Container(
                                              height: 156,
                                              width: 156,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                            : Container(
                                          color: AppColors.primaryColor30,
                                              child: CustomImageShimmer(
                                          imageUrl: review?.mediaUrl ?? '',
                                          width: (MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                110,
                                          height: (MediaQuery.of(context)
                                                    .size
                                                    .width) -
                                                110,
                                          fit: BoxFit.contain,
                                        ),
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ];
              },
              body: SafeArea(
                child: SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: ReviewRepo.reviewFireInstance
                          .where('rid', isEqualTo: widget.reviewId)
                          .snapshots(),
                    builder: (context, snapshot) {

                      final documents = snapshot.data?.docs;
                      UploadReviewModel? review;

                      if (documents != null && documents.isNotEmpty) {
                        final firstDocument = documents[0];
                        review = UploadReviewModel.fromMap(
                            firstDocument.data() as Map<String, dynamic>);
                      }

                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [ContainerShadow.boxShadow[1]],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                AppBoarderRadius.reviewUploadRadius + 10),
                            topRight: Radius.circular(
                                AppBoarderRadius.reviewUploadRadius + 10),
                          ),
                          color: AppColors.primaryColor30,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              width: 60,
                              height: 7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.iconLightColor),
                            ),
                            // Review Upload Fields
                            // Container(
                            //   padding: EdgeInsets.all(30),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Flexible(
                            //             child: Text(review?.text ?? '',
                            //                 maxLines: 2,
                            //                 overflow: TextOverflow.ellipsis,
                            //                 style: ViewReviewFonts.titleText()),
                            //           ),
                            //           Row(children: [
                            //             Text(review?.price[0] ?? '',
                            //                 style: ViewReviewFonts.titleText(
                            //                     color: AppColors.secondaryColor10)),
                            //             Text((review?.price.substring(1) ?? '').length > 11
                            //                 ? (review?.price.substring(1, 9) ?? '') + '...'
                            //                 : (review?.price.substring(1) ?? ''),
                            //                 style: ViewReviewFonts.titleText())
                            //           ]),
                            //         ],
                            //       ),
                            //       SizedBox(height: 6),
                            //       Text((review?.brand ?? '').length > 34
                            //           ? (review?.brand ?? '').substring(0, 33) + '...'
                            //           : (review?.brand ?? ''),
                            //           style:
                            //           ViewReviewFonts.subTitleText(fontSize: 14)),
                            //       SizedBox(height: 4),
                            //       Text((review?.category ?? '').length > 34
                            //           ? (review?.category ?? '').substring(0, 33) + '...'
                            //           : (review?.category ?? ''),
                            //           style:
                            //           ViewReviewFonts.subTitleText(fontSize: 14)),
                            //       SizedBox(height: 10),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Expanded(
                            //             child: Container(
                            //               alignment: Alignment.centerRight,
                            //               height: 24,
                            //               child: ListView.builder(
                            //                 scrollDirection: Axis.horizontal,
                            //                 itemCount: AppValues.maxRating,
                            //                 itemBuilder:
                            //                     (BuildContext context, int index) {
                            //                   return Row(
                            //                     children: [
                            //                       Icon(Icons.star,
                            //                           size: 24,
                            //                           color: index < (review?.rating ?? 0)
                            //                               ? AppColors.starColor
                            //                               : AppColors.iconLightColor),
                            //                       SizedBox(width: 2)
                            //                     ],
                            //                   );
                            //                 },
                            //               ),
                            //             ),
                            //           ),
                            //           InkWell(
                            //             onTap: () {
                            //               navigateToUserProfile(context, review?.userId ?? -1);
                            //             },
                            //             child: Text(('@${review?.username ?? ''}').length > 20
                            //                 ? ('@${review?.username ?? ''}').substring(0, 19) + '...'
                            //                 : ('@${review?.username ?? ''}'),
                            //                 style: ViewReviewFonts.reviewUserText()),
                            //           )
                            //         ],
                            //       ),
                            //       SizedBox(height: 20),
                            //       Text('Description',
                            //           style: ViewReviewFonts.contentLabelText()),
                            //       SizedBox(height: 8),
                            //       Text((review?.description ?? ''),
                            //         maxLines: 6,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: ViewReviewFonts.contentText(),
                            //       ),
                            //       SizedBox(height: 20),
                            //       Text('Summary',
                            //           style: ViewReviewFonts.contentLabelText()),
                            //       SizedBox(height: 8),
                            //       Text(
                            //         (review?.summary ?? ''),
                            //         maxLines: 36,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: ViewReviewFonts.contentText(),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20, left: 20, right: 20, bottom: 40),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: ContainerShadow.boxShadow,
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppBoarderRadius
                                                .reviewUploadRadius),
                                        child: review?.mediaUrl == 'null'
                                            ? SizedBox(
                                          width: (MediaQuery.of(context)
                                              .size
                                              .width) -
                                              80,
                                          height: (MediaQuery.of(context)
                                              .size
                                              .width) -
                                              80,
                                          child: Shimmer.fromColors(
                                            baseColor: Color(0xFFe4e4e4),
                                            highlightColor: Color(0xFFCDCDCD),
                                            child: Container(
                                              height: 156,
                                              width: 156,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                            : Container(
                                          color: AppColors.primaryColor30,
                                              child: CustomImageShimmer(
                                          imageUrl: review?.mediaUrl ?? '',
                                          width: (MediaQuery.of(context)
                                                .size
                                                .width) -
                                                80,
                                          height: (MediaQuery.of(context)
                                                .size
                                                .width) -
                                                80,
                                          fit: BoxFit.contain,
                                        ),
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              )),
        ));
  }
}
