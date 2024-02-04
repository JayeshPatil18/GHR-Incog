import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../widgets/line.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  static String searchText = '';

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {

  TextEditingController searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    MyApp.initUserId();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    MyApp.initUserId();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(76),
            child: SafeArea(
              child: Column(
                children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 12, bottom: 12, right: 20, left: 20),
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            child: TextField(
                              style: MainFonts.searchText(color: AppColors.primaryColor30),
                              focusNode: _focusNode,
                              controller: searchTextController,
                              // cursorHeight: TextCursorHeight.cursorHeight,
                              onChanged: (value) {
                                setState(() {
                                  LikedPage.searchText =
                                      value.trim().toLowerCase();
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 20, right: 20),
                                fillColor: AppColors.transparentComponentColor,
                                filled: true,
                                hintText: 'Search Products',
                                hintStyle: MainFonts.searchText(color: AppColors.transparentComponentColor),
                                prefixIcon: Icon(Icons.search_rounded, color: AppColors.transparentComponentColor,),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      18),
                                  borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 8,
                              child: searchTextController.text != '' ? GestureDetector(
                                onTap: () {
                                  searchTextController.text = '';
                                  setState(() {
                                    LikedPage.searchText = '';
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(right: 4),
                                  child: Icon(Icons.cancel_rounded,
                                      color: AppColors.transparentComponentColor),
                                ),
                              ) : SizedBox(width: 0, height: 0,)),

                          // Positioned(
                          //     right: 8,
                          //     child: CircleIconContainer(
                          //         icon: const Icon(Icons.search,
                          //             color: AppColors.primaryColor30),
                          //         containerColor: AppColors.secondaryColor10,
                          //         containerSize: 40)),
                        ],
              ),
                      ),
                    ),
                    Text('Cancel', style: MainFonts.searchText(color: AppColors.primaryColor30),)
                  ],
                ),
                  Line()
                ],
              ),
            )),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(height: 98),
              // Review GridView
              // Expanded(
              //     child: StreamBuilder<QuerySnapshot>(
              //         stream: ReviewRepo.reviewFireInstance.where('likedBy', arrayContains: MyApp.userId).orderBy('date', descending: true).snapshots(),
              //         builder: (context, snapshot) {
              //           final documents;
              //           if (snapshot.data != null) {
              //             documents = snapshot.data!.docs;
              //             if(documents.length < 1){
              //               return Center(child: Text('No Review Liked', style: MainFonts.filterText(color: AppColors.textColor)));
              //             }
              //             return GridView.builder(
              //                 padding: EdgeInsets.only(
              //                     top: 10, bottom: 100, left: 20, right: 20),
              //                 gridDelegate:
              //                     const SliverGridDelegateWithFixedCrossAxisCount(
              //                         crossAxisSpacing: 20,
              //                         mainAxisSpacing: 20,
              //                         crossAxisCount: 2,
              //                         childAspectRatio: (100 / 158)),
              //                 scrollDirection: Axis.vertical,
              //                 itemCount: documents.length,
              //                 itemBuilder: (BuildContext context, int index) {
              //                   UploadReviewModel review =
              //                       UploadReviewModel.fromMap(documents[index]
              //                           .data() as Map<String, dynamic>);
              //
              //                   return ReviewModel(
              //                       reviewId: review.postId,
              //                       imageUrl: review.mediaUrl,
              //                       price: review.price,
              //                       isLiked: review.likedBy.contains(MyApp.userId),
              //                       title: review.text,
              //                       brand: review.brand,
              //                       category: review.category,
              //                       date: review.date
              //                           .substring(0, 10)
              //                           .replaceAll('-', '/'),
              //                       rating: review.rating);
              //                 });
              //           } else {
              //             return Center(child: CircularProgressIndicator());
              //           }
              //         })),
        ],
      )
    );
  }
}