import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_profile_model.dart';
import 'package:review_app/main.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../../../authentication/data/repositories/users_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/post_model.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/tabs_profile.dart';
import '../widgets/view_replies_model.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  ScrollController _scrollController = ScrollController();
  bool lastStatus = true;
  double height = 200;
  String userRank = '';

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
    return StreamBuilder<QuerySnapshot>(
        stream: UsersRepo.userFireInstance.snapshots(),
        builder: (context, snapshot) {
          final documents;
          documents = snapshot.data?.docs;
          List<Map<String, dynamic>> usersData = [];
          User? user;

          if (documents != null && documents.isNotEmpty) {
            final firstDocument = documents[0];

            if (firstDocument != null &&
                firstDocument.data() != null &&
                firstDocument.data().containsKey('userslist')) {
              usersData = List<Map<String, dynamic>>.from(
                  firstDocument.data()['userslist']);

              List<User> usersList =
              usersData.map((userData) => User.fromMap(userData)).toList();

              List<User> users =
              usersList.where((user) => user.uid == MyApp.userId).toList();
              user = users.first;
            }
          }
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(72),
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      child: Text('Activity', style: MainFonts.pageTitleText()),
                    ),
                  )),
              backgroundColor: Colors.transparent,
              body: DefaultTabController(
                length: 2,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 52,
                            child: TabBar(
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorWeight: 2,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                tabs: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Tab(
                                        text: "  Likes  ",
                                      ),
                                      SizedBox(height: 2)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Tab(
                                        text: "  Comments  ",
                                      ),
                                      SizedBox(height: 2)
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            color: Colors.grey,
                            height: 0.3,
                          )
                        ],
                      ),
                      Expanded(
                          child: TabBarView(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: ReviewRepo.reviewFireInstance
                                  .where('likedby', arrayContains: MyApp.userId)
                                      .orderBy('date', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    final documents;
                                    if (snapshot.data != null) {
                                      documents = snapshot.data!.docs;

                                      List<UploadReviewModel> documentList = [];
                                      List<UploadReviewModel> postsList = [];
                                      for (int i = 0;
                                      i < documents.length;
                                      i++) {
                                        UploadReviewModel post =
                                        UploadReviewModel.fromMap(
                                            documents[i].data()
                                            as Map<String, dynamic>);
                                        documentList.add(post);
                                        if (post.parentId == "-1") {
                                          postsList.add(post);
                                        }
                                      }

                                      if(postsList.isNotEmpty){
                                        return ListView.builder(
                                            padding: EdgeInsets.only(bottom: 100),
                                            itemCount: postsList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              UploadReviewModel post =
                                              postsList[index];

                                              int commentCount = 0;
                                              bool isCommented = false;
                                              for (UploadReviewModel i
                                              in documentList) {
                                                if (post.postId == i.parentId) {
                                                  if (MyApp.userId == i.userId) {
                                                    isCommented = true;
                                                  }
                                                  commentCount++;
                                                }
                                              }

                                              return PostModel(
                                                commentCount: commentCount,
                                                isCommented: isCommented,
                                                date: post.date,
                                                likedBy: post.likedBy,
                                                mediaUrl: post.mediaUrl,
                                                gender: post.gender,
                                                userProfileUrl:
                                                post.userProfileUrl,
                                                parentId: post.parentId,
                                                postId: post.postId,
                                                text: post.text,
                                                userId: post.userId,
                                                username: post.username,
                                              );
                                            });
                                      } else{
                                        return Center(
                                            child: Text('No Post',
                                                style: MainFonts.filterText(
                                                    color:
                                                    AppColors.lightTextColor)));
                                      }
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                              StreamBuilder<QuerySnapshot>(
                                  stream: ReviewRepo.reviewFireInstance
                                      .orderBy('date', descending: true)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    final documents;
                                    if (snapshot.data != null) {
                                      documents = snapshot.data!.docs;

                                      List<UploadReviewModel> documentList = [];
                                      List<UploadReviewModel> postsList = [];
                                      for (int i = 0;
                                      i < documents.length;
                                      i++) {
                                        UploadReviewModel post =
                                        UploadReviewModel.fromMap(
                                            documents[i].data()
                                            as Map<String, dynamic>);
                                        documentList.add(post);
                                        if (post.parentId != "-1" && post.userId == MyApp.userId) {
                                          postsList.add(post);
                                        }
                                      }

                                      if(postsList.isNotEmpty){
                                        return ListView.builder(
                                            padding: EdgeInsets.only(bottom: 100),
                                            itemCount: postsList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              UploadReviewModel post =
                                              postsList[index];
                                              UploadReviewModel? parentPost;

                                              int commentCount = 0;
                                              bool isCommented = false;

                                              int parentCommentCount = 0;
                                              bool isParentCommented = false;

                                              for (UploadReviewModel i
                                              in documentList) {

                                                if(post.parentId == i.postId){
                                                  parentPost = i;
                                                }

                                                if (post.postId == i.parentId) {
                                                  if (MyApp.userId == i.userId) {
                                                    isCommented = true;
                                                  }
                                                  commentCount++;
                                                }

                                                if (post.parentId == i.parentId) {
                                                  if (MyApp.userId == i.userId) {
                                                    isParentCommented = true;
                                                  }
                                                  parentCommentCount++;
                                                }
                                              }

                                              return Column(
                                                children: [
                                                  RepliesModel(
                                                    commentCount: parentCommentCount,
                                                    isCommented: isParentCommented,
                                                    date: parentPost?.date ?? '',
                                                    likedBy: parentPost?.likedBy ?? [],
                                                    mediaUrl: parentPost?.mediaUrl ?? '',
                                                    gender: parentPost?.gender ?? '',
                                                    userProfileUrl: parentPost?.userProfileUrl ?? '',
                                                    parentId: parentPost?.parentId ?? '',
                                                    postId: parentPost?.postId ?? '',
                                                    text: parentPost?.text ?? '',
                                                    userId: parentPost?.userId ?? -1,
                                                    username: parentPost?.username ?? '',
                                                  ),
                                                  PostModel(
                                                    commentCount: commentCount,
                                                    isCommented: isCommented,
                                                    date: post.date,
                                                    likedBy: post.likedBy,
                                                    mediaUrl: post.mediaUrl,
                                                    gender: post.gender,
                                                    userProfileUrl:
                                                    post.userProfileUrl,
                                                    parentId: post.parentId,
                                                    postId: post.postId,
                                                    text: post.text,
                                                    userId: post.userId,
                                                    username: post.username,
                                                  ),
                                                ],
                                              );
                                            });
                                      } else{
                                        return Center(
                                            child: Text('No Comments',
                                                style: MainFonts.filterText(
                                                    color:
                                                    AppColors.lightTextColor)));
                                      }
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          )),
                    ],
                  ),
                ),
              ));
        });
  }
}
