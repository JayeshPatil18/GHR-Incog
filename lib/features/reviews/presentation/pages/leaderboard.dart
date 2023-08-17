import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_model.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
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
                  Text('Ranking', style: pageTitleText()),
                  Container(
                        decoration: BoxDecoration(
                          boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.textColor,
                          borderRadius: BorderRadius.circular(
                              AppBoarderRadius.filterRadius),
                        ),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 13, right: 13),
                        child: Text('My Rank',
                            style: filterText(color: AppColors.primaryColor30)),
                      ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 90),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return UserModel(profileUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', name: 'Henry Tyson', username: 'henrytyson', rank: 1, points : 400);
                },
              ),
            )
          ],
        ),
      )
    );
  }
}