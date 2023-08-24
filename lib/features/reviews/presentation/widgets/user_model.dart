import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';

class UserModel extends StatefulWidget {

  final String profileUrl;
  final String name;
  final String username;
  final int rank;
  final int points;

  const UserModel({super.key, 
    required this.profileUrl,
    required this.name,
    required this.username,
    required this.rank,
    required this.points
  });

  @override
  State<UserModel> createState() => _UserModelState();
}

class _UserModelState extends State<UserModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppBoarderRadius.userModelRadius),
        color: AppColors.primaryColor30,
        boxShadow: ContainerShadow.boxShadow
      ),
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.textColor,
                                  width: 1.5,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(widget.profileUrl),
                                radius: 40,
                              )
                            ),
                            SizedBox(width: 20),
                            Flexible(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.name,
                                      style: UserModelFonts.userRankingTitle(),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '@${widget.username}',
                                      style: UserModelFonts.userRankingSubTitle(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(suffixOfNumber(widget.rank), style: UserModelFonts.userRankingTitle()),
                            SizedBox(height: 6),
                            Text('Pts. ${widget.points}',
                                style: UserModelFonts.userRankingSubTitle()),
                          ],
                        ),
                        contentPadding:
                        EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
                        onTap: () {
                        },
                        onLongPress: () {},
                      ));
  }
}