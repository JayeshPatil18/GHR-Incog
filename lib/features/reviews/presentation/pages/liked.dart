import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  
  @override
  void initState() {
    MyApp.initUserId();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    MyApp.initUserId();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Liked', style: MainFonts.pageTitleText()),
                  // GestureDetector(
                  //   onTap: (() {
                  //     showDialog<String>(
                  //         context: context,
                  //         builder: (BuildContext context) => AlertDialog(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(30),
                  //           ),
                  //           title: const Text('Clear all'),
                  //           content: const Text(
                  //               'All Likes will be removed.'),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               onPressed: () {
                  //                 Navigator.pop(context, 'Cancel');
                  //               },
                  //               child: const Text('Cancel'),
                  //             ),
                  //             TextButton(
                  //               onPressed: () {
                  //                 Navigator.pop(context, 'OK');
                  //               },
                  //               child: const Text('OK'),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //   }),
                  //   child: Container(
                  //         decoration: BoxDecoration(
                  //           boxShadow: ContainerShadow.boxShadow,
                  //           color: AppColors.textColor,
                  //           borderRadius: BorderRadius.circular(
                  //               AppBoarderRadius.filterRadius),
                  //         ),
                  //         padding: EdgeInsets.only(
                  //             top: 10, bottom: 10, left: 13, right: 13),
                  //         child: Text('Clear All',
                  //             style: MainFonts.filterText(color: AppColors.primaryColor30)),
                  //       ),
                  // ),
                ],
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
        ),
      )
    );
  }
}