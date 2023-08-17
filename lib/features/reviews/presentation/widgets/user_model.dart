import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../utils/fonts.dart';

class UserModel extends StatelessWidget {
  const UserModel({super.key});

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
                                backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/3135/3135715.png'),
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
                                      'Harry Marsh',
                                      style: userRankingTitle(),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '@harshmarsh',
                                      style: userRankingSubTitle(),
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
                            Text('1st', style: userRankingTitle()),
                            SizedBox(height: 6),
                            Text('Pts. 400',
                                style: userRankingSubTitle()),
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