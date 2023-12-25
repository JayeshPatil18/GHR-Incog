import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/features/authentication/data/repositories/users_repo.dart';
import 'package:review_app/features/reviews/data/repositories/review_repo.dart';
import 'package:review_app/features/reviews/domain/entities/user.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_model.dart';
import 'package:review_app/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  static final itemController = ItemScrollController();

  static void scrollToIndex(int index) => itemController.scrollTo(
    index: index,
    duration: Duration(milliseconds: 600),
  );

  int scrollIndex = -1;

  _setScrollIndex(int index) {
    scrollIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ranking', style: MainFonts.pageTitleText()),
                        GestureDetector(
                          onTap: () async {
                            scrollToIndex(scrollIndex);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: ContainerShadow.boxShadow,
                              color: AppColors.textColor,
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.filterRadius),
                            ),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 13, right: 13),
                            child: Text('My Rank',
                                style: MainFonts.filterText(
                                    color: AppColors.primaryColor30)),
                          ),
                        ),
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
                            return ScrollablePositionedList.builder(
                              padding: EdgeInsets.only(
                                  top: 10, left: 14, right: 14, bottom: 90),
                              itemScrollController: itemController,
                              itemCount: usersList.length,
                              itemBuilder: (context, index) {
                                User user = usersList[index];

                                if (user.uid == MyApp.userId) {
                                  _setScrollIndex(user.uid);
                                }
                                return UserModel(
                                    uId: user.uid,
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
              Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6)
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                    child: Container(
                      width: 300,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300]?.withOpacity(0.4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 60,
                            color: AppColors.iconColor,
                          ),
                          SizedBox(height: 20),
                          Text('This feature will be available soon', style: MainFonts.filterText(color: AppColors.textColor),)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
