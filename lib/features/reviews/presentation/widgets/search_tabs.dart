import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/post_model.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_model.dart';

import '../../../../constants/color.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../..'
    '/authentication/data/repositories/users_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../pages/search.dart';

class PostsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostsTabState();
  }
}

class PostsTabState extends State<PostsTab> {
  var elevationValue = 0.0;
  List<Map> tweetsList = [{}, {}, {}, {}];

  // Future _refresh() async{
  //   var list = await getTweets();
  //   setState(() {
  //     tweetsList.clear();
  //     tweetsList = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: ReviewRepo.reviewFireInstance.orderBy('date', descending: true).snapshots(),
            builder: (context, snapshot) {
              final documents;
              if (snapshot.data != null) {
                documents = snapshot.data!.docs;

                List<UploadReviewModel> documentList = [];
                List<UploadReviewModel> postsList = [];
                for(int i = 0; i < documents.length; i++){
                  UploadReviewModel post = UploadReviewModel.fromMap(documents[i].data() as Map<String, dynamic>);
                  documentList.add(post);
                  if(post.parentId == "-1"){
                    postsList.add(post);
                  }
                }

                List<UploadReviewModel> resultPosts = postsList.skipWhile((UploadReviewModel element) {
                  return !(element.text.toLowerCase().contains(SearchPage.searchText.toLowerCase()));
                }).toList();

                if(resultPosts.isNotEmpty){
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: resultPosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        UploadReviewModel post = resultPosts[index];

                        int commentCount = 0;
                        bool isCommented = false;
                        for(UploadReviewModel i in documentList){
                          if(post.postId == i.parentId){
                            if(MyApp.userId == i.userId){
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
                          userProfileUrl: post.userProfileUrl,
                          parentId: post.parentId,
                          postId: post.postId,
                          text: post.text,
                          userId: post.userId,
                          username: post.username,
                        );
                      });
                } else{
                  return Center(child: Text('No Results', style: MainFonts.filterText(color: AppColors.textColor)));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }

//   Future<List<TweetsModel>> getTweets() async {
//     int userId = await getTokenId();
//     final response =
//     await http.get(Uri.parse('$globalApiUrl/users/tweets?userId=${userId}'));
//     var data = jsonDecode(response.body);
//     tweetsList.clear();
//     if (response.statusCode == 200) {
//       for (Map i in data) {
//         tweetsList.add(TweetsModel.fromJson(i));
//       }
//       return tweetsList;
//     } else {
//       return tweetsList;
//     }
//   }
// }
}

class ProfilesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilesTabState();
  }
}

class ProfilesTabState extends State<ProfilesTab> {
  var elevationValue = 0.0;
  List<Map> tweetsList = [{}, {}, {}, {}];

  // Future _refresh() async{
  //   var list = await getTweets();
  //   setState(() {
  //     tweetsList.clear();
  //     tweetsList = list;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: UsersRepo.userFireInstance.snapshots(),
          builder: (context, snapshot) {
            final documents;
            if (snapshot.data != null) {
              documents = snapshot.data!.docs;
              List<Map<String, dynamic>> usersData =
              List<Map<String, dynamic>>.from(
                  documents[0].data()['userslist']);

              List<User> usersList = usersData
                  .map((userData) => User.fromMap(userData))
                  .toList();

              List<User> resultProfiles = usersList.skipWhile((User element) {
                return !(element.username.toLowerCase().startsWith(SearchPage.searchText.toLowerCase()));
              }).toList();

              if (resultProfiles.length < 1) {
                return Center(
                    child: Text('No Results',
                        style: MainFonts.filterText(
                            color: AppColors.textColor)));
              }
              return ListView.builder(
                padding: EdgeInsets.only(
                    top: 16, left: 14, right: 14, bottom: 90),
                itemCount: resultProfiles.length,
                itemBuilder: (context, index) {
                  User user = resultProfiles[index];

                  return UserModel(
                      uId: user.uid,
                      profileUrl: user.profileUrl,
                      username: user.username,
                      rank: user.rank,
                      points: user.score);
                },
              );
            } else {
              return Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    );
  }

// Future<List<TweetsModel>> getTweets() async {
//   int userId = await getTokenId();
//   final response =
//   await http.get(Uri.parse('$globalApiUrl/users/likes?userId=${userId}'));
//   var data = jsonDecode(response.body);
//   tweetsList.clear();
//   if (response.statusCode == 200) {
//     for (Map i in data) {
//       tweetsList.add(TweetsModel.fromJson(i));
//     }
//     return tweetsList;
//   } else {
//     return tweetsList;
//   }
// }
}
