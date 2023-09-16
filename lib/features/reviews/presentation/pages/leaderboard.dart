import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/features/authentication/data/repositories/users_repo.dart';
import 'package:review_app/features/reviews/data/repositories/review_repo.dart';
import 'package:review_app/features/reviews/domain/entities/user.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_model.dart';
import 'package:review_app/main.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  
  // final itemController = ItemScrollController();
  
  // void scrollToIndex(int index) => itemController.scrollTo(
  //   index: index,
  //   duration: Duration(milliseconds: 600),
  // );

int scrollIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ranking', style: MainFonts.pageTitleText()),
                    // GestureDetector(
                    //   onTap: () async{
                    //     // scrollToIndex(scrollIndex);
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       boxSh  adow: ContainerShadow.boxShadow,
                    //       color: AppColors.textColor,
                    //       borderRadius: BorderRadius.circular(
                    //           AppBoarderRadius.filterRadius),
                    //     ),
                    //     padding: EdgeInsets.only(
                    //         top: 10, bottom: 10, left: 13, right: 13),
                    //     child: Text('My Rank',
                    //         style: MainFonts.filterText(
                    //             color: AppColors.primaryColor30)),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
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

                            usersList.sort((a, b) => a.rank.compareTo(b.rank));
                            
                        if (usersList.length < 1) {
                          return Center(
                              child: Text('No Users',
                                  style: MainFonts.filterText(
                                      color: AppColors.textColor)));
                        }
                        return ListView.builder(
                          padding: EdgeInsets.only(
                              top: 10, left: 14, right: 14, bottom: 90),
                          itemCount: usersList.length,
                          itemBuilder: (context, index) {
                            User user = usersList[index];

                            // if(user.uid == MyApp.userId){
                            //   scrollIndex = user.rank;
                            // }
                            return UserModel(
                                profileUrl: user.profileUrl,
                                name: user.fullName,
                                username: user.username,
                                rank: user.rank,
                                points: user.points);
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
