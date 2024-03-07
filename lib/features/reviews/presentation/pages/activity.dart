import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:review_app/features/reviews/presentation/widgets/dialog_box.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_profile_model.dart';
import 'package:review_app/main.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/method1.dart';
import '../../../authentication/data/repositories/users_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/string_argument.dart';
import '../../domain/entities/two_string_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../widgets/custom_rich_text.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/line.dart';
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
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CustomDialogBox(title: Text('Are you sure you want to exit?', style: TextStyle(fontSize: 18)), content: null, textButton1: TextButton(
                child: Text('Yes, exit', style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ), textButton2: TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ));
            }
        );

        return value == true;
      },
      child: StreamBuilder<QuerySnapshot>(
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
                                            postsList.add(post);
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

                                                return GestureDetector(
                                                  onTap: (){
                                                    if(post.parentId == '-1'){
                                                      Navigator.pushNamed(context, 'view_post', arguments: StringArguments(post.postId));
                                                    }
                                                  },
                                                  child: PostModel(
                                                    isActivityModel: true,
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

                                                int postModelTextMaxLines = 6;
                                                bool showMore = false;

                                                final maxLines = showMore ? 100 : postModelTextMaxLines;

                                                return GestureDetector(
                                                  onTap: () {
                                                    if(parentPost?.parentId == '-1'){
                                                      Navigator.pushNamed(context, 'view_post', arguments: StringArguments(parentPost?.postId ?? ''));
                                                    } else{
                                                      Navigator.pushNamed(context, 'view_replies', arguments: TwoStringArg(parentPost?.parentId ?? '', parentPost?.postId ?? ''));
                                                    }
                                                  },
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 20),
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
                                                      Column(
                                                        children: [
                                                          Container(
                                                            color: Colors.transparent,
                                                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 16),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.only(right: 5, bottom: 3),
                                                                      child: post.userProfileUrl == 'null' || post.userProfileUrl.isEmpty
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
                                                                                imageUrl: post.userProfileUrl,
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                fit: BoxFit.cover)),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      bottom: 0,
                                                                      right: 0,
                                                                      child: Container(
                                                                          child: Image.asset('assets/icons/reply-fill.png',
                                                                              color: AppColors.secondaryColor10,
                                                                              height: 20,
                                                                              width: 20)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(width: 10),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                  post.username.length > 20
                                                                                      ? post.username.substring(0, 20) + '...'
                                                                                      : post.username,
                                                                                  style: MainFonts.lableText(
                                                                                      fontSize: 16, weight: FontWeight.w500)),
                                                                              SizedBox(width: 6),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: AppColors.transparentComponentColor,
                                                                                    borderRadius: BorderRadius.circular(3.0)),
                                                                                padding: EdgeInsets.only(
                                                                                    top: 2, bottom: 2, left: 3.5, right: 3.5),
                                                                                child: Text(post.gender.isNotEmpty ? post.gender[0].toUpperCase() : ' - ',
                                                                                    style: TextStyle(
                                                                                        fontSize: 11,
                                                                                        color: AppColors.primaryColor30)),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          Text(formatDateTime(post.date),
                                                                              style: MainFonts.miniText(
                                                                                  fontSize: 11, color: AppColors.lightTextColor)),
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 10),
                                                                      post.text.isEmpty ? SizedBox() : AutoSizeText.rich(
                                                                        CustomRichText.buildTextSpan(post.text.split(RegExp(r'(?<=\s|\n)')), MainFonts.postMainText(size: 16), MainFonts.postMainText(size: 16, color: AppColors.secondaryColor10)),
                                                                        maxLines: postModelTextMaxLines,
                                                                        style: MainFonts.postMainText(size: 16),
                                                                        minFontSize: 16,
                                                                        overflowReplacement: Column(
                                                                          // This widget will be replaced.
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          children: <Widget>[
                                                                            CustomRichText(
                                                                                wordsList: post.text.split(RegExp(r'(?<=\s|\n)')),
                                                                                maxLines: maxLines,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                defaultStyle:
                                                                                MainFonts.postMainText(size: 16),
                                                                                highlightStyle:
                                                                                MainFonts.postMainText(size: 16, color: AppColors.secondaryColor10)),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  showMore = !showMore;
                                                                                });
                                                                              },
                                                                              child: Padding(
                                                                                padding: EdgeInsets.only(top: 8.0),
                                                                                child: Text(showMore ? 'See less' : 'See more',
                                                                                    style: MainFonts.lableText(
                                                                                        color: AppColors.secondaryColor10,
                                                                                        fontSize: 14,
                                                                                        weight: FontWeight.bold)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      post.mediaUrl == 'null' || post.mediaUrl.isEmpty ? SizedBox(height: 0) : Column(
                                                                        children: [
                                                                          const SizedBox(height: 16),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              FocusScope.of(context).unfocus();
                                                                              Navigator.pushNamed(context, 'view_image', arguments: ImageViewArguments(post.mediaUrl , true));
                                                                            },
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(20),
                                                                              ),
                                                                              width: MediaQuery.of(context).size.width,
                                                                              height: 260,
                                                                              child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  child: CustomImageShimmer(
                                                                                      imageUrl: post.mediaUrl,
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      fit: BoxFit.cover)),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const SizedBox(height: 16),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            child: isCommented ? Image.asset('assets/icons/reply-fill.png',
                                                                                color: AppColors.secondaryColor10,
                                                                                height: 19,
                                                                                width: 19) : Image.asset('assets/icons/reply.png',
                                                                                color: AppColors.primaryColor30,
                                                                                height: 19,
                                                                                width: 19),
                                                                          ),
                                                                          const SizedBox(width: 5),
                                                                          Text(commentCount.toString(), style: MainFonts.postMainText(size: 13)),
                                                                          const SizedBox(width: 40),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              ReviewRepo reviewRepo = ReviewRepo();
                                                                              reviewRepo.likeReview(post.postId, post.likedBy.contains(MyApp.userId));
                                                                            },
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: post.likedBy.contains(MyApp.userId) ? Image.asset('assets/icons/like-fill.png',
                                                                                      color: AppColors.heartColor,
                                                                                      height: 19,
                                                                                      width: 19) : Image.asset('assets/icons/like.png',
                                                                                      color: AppColors.primaryColor30,
                                                                                      height: 19,
                                                                                      width: 19),
                                                                                ),
                                                                                const SizedBox(width: 5),
                                                                                Text(post.likedBy.length.toString(),
                                                                                    style: MainFonts.postMainText(size: 12)),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Line()
                                                        ],
                                                      )
                                                    ],
                                                  ),
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
          }),
    );
  }
}
