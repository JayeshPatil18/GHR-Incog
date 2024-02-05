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
import '../widgets/image_shimmer.dart';
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

    _focusNode.addListener(() {
      setState(() {
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    MyApp.initUserId();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            style: MainFonts.searchText(color: AppColors.primaryColor30),
                            focusNode: _focusNode,
                            controller: searchTextController,
                            onChanged: (value) {
                              setState(() {
                                LikedPage.searchText =
                                    value.trim().toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 2, bottom: 2),
                              fillColor: AppColors.transparentComponentColor,
                              filled: true,
                              hintText: 'Search Products',
                              hintStyle: MainFonts.searchText(color: AppColors.transparentComponentColor),
                              prefixIcon: Icon(Icons.search_rounded, color: AppColors.transparentComponentColor,),
                              suffixIcon: LikedPage.searchText == "" ? null : GestureDetector(
                                  onTap: () {
                                    searchTextController.text = '';
                                    setState(() {
                                      LikedPage.searchText = '';
                                    });
                                  },
                                  child: Icon(Icons.cancel_rounded, color: AppColors.transparentComponentColor,)),
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
                        _focusNode.hasFocus ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                              onTap: () {
                                _focusNode.unfocus();
                              },
                              child: Text('Cancel', style: MainFonts.searchText(color: AppColors.primaryColor30))),
                        ) : SizedBox()
                      ],
                    ),
                  ),
                  Line()
                ],
              ),
            )),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(height: 98),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 20, bottom: 100, right: 20, left: 20),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: 'widget.userProfileUrl' == 'null' || 'widget.userProfileUrl'.isEmpty
                                  ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 18,
                                child: ClipOval(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: AppColors.transparentComponentColor,
                                    child: Icon(Icons.person, color: AppColors.lightTextColor,),
                                  ),
                                ),
                              ) : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 18,
                                child: ClipOval(
                                    child: CustomImageShimmer(
                                        imageUrl: 'widget.userProfileUrl',
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                                'widget.username'.length > 20
                                    ? 'widget.username'.substring(0, 20) + '...'
                                    : 'widget.username',
                                style: MainFonts.lableText(
                                    fontSize: 16, weight: FontWeight.w500)),
                            SizedBox(width: 6),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.transparentComponentColor,
                                  borderRadius: BorderRadius.circular(3.0)),
                              padding: EdgeInsets.only(
                                  top: 2, bottom: 2, left: 3.5, right: 3.5),
                              child: Text('widget.gender'.isNotEmpty ? 'widget.gender'[0].toUpperCase() : ' - ',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.primaryColor30)),
                            )
                          ],
                        ),
                        Text('widget.date'.substring(0, 10).replaceAll('-', '/'),
                            style: MainFonts.miniText(
                                fontSize: 11, color: AppColors.lightTextColor)),
                      ],
                    ),)
                ],
              ),
            ),
          ),
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