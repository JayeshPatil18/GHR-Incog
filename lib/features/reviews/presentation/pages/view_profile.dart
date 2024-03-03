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
import '../widgets/dialog_box.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/post_model.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/tabs_profile.dart';

class ViewProfile extends StatefulWidget {
  final int userId;
  const ViewProfile({super.key, required this.userId});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
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
              usersList.where((user) => user.uid == widget.userId).toList();
              user = users.first;
            }
          }
          return Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              body: Container(
                decoration: BoxDecoration(gradient: AppColors.mainGradient),
                child: SafeArea(
                  child: DefaultTabController(
                    length: 2,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // _refresh();
                      },
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin:
                            EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios,
                                          color: AppColors.textColor, size: 20),
                                    ),
                                    SizedBox(width: 10),
                                    Text('Profile', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
                                  ],
                                ),
                                MyApp.ENABLE_LEADERBOARD ? Container(
                                  margin: EdgeInsets.only(top: 6, bottom: 6),
                                  decoration: BoxDecoration(
                                      color: AppColors.transparentComponentColor,
                                      borderRadius: BorderRadius.circular(3.0)),
                                  padding: EdgeInsets.only(
                                      top: 4, bottom: 4, left: 4.5, right: 4.5),
                                  child: Text('#${user?.rank ?? ''}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primaryColor30)),
                                ) : SizedBox()
                              ],
                            ),
                          ),
                          Expanded(
                            child: NestedScrollView(
                              headerSliverBuilder: (context, _) {
                                return [
                                  SliverList(
                                    delegate: SliverChildListDelegate([
                                      UserProfileModel(
                                        hideEditBtn: true,
                                        profileUrl: user?.profileUrl ?? 'null',
                                        username: user?.username ?? '',
                                        rank: user?.rank ?? -1,
                                        score: user?.score ?? -1,
                                        bio: user?.bio ?? '',
                                        gender: user?.gender ?? '',
                                      )
                                    ]),
                                  )
                                ];
                              },
                              body: Container(
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
                                                      text: "  Posts  ",
                                                    ),
                                                    SizedBox(height: 2)
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Tab(
                                                      text: "  Media  ",
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
                                                    .where('userid', isEqualTo: widget.userId)
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
                                                    .where('userid', isEqualTo: widget.userId)
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
                                                      if (post.parentId == "-1" && post.mediaUrl != 'null') {
                                                        postsList.add(post);
                                                      }
                                                    }

                                                    if(postsList.isNotEmpty){
                                                      return GridView.builder(
                                                          padding: EdgeInsets.only(
                                                              bottom: 100),
                                                          gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisSpacing: 2,
                                                            mainAxisSpacing: 2,
                                                            crossAxisCount: 3,),
                                                          scrollDirection: Axis.vertical,
                                                          itemCount: postsList.length,
                                                          itemBuilder: (BuildContext context,
                                                              int index) {
                                                            UploadReviewModel post =
                                                            postsList[index];

                                                            return GestureDetector(
                                                              onTap: () {
                                                                Navigator.pushNamed(context, 'view_image', arguments: ImageViewArguments(post.mediaUrl , true));
                                                              },
                                                              child: Container(
                                                                child: ClipRRect(
                                                                    child: CustomImageShimmer(
                                                                        imageUrl: post.mediaUrl,
                                                                        width: double.infinity,
                                                                        height: double.infinity,
                                                                        fit: BoxFit.cover)),
                                                              ),
                                                            );
                                                          });
                                                    } else{
                                                      return Center(
                                                          child: Text('No Media',
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
