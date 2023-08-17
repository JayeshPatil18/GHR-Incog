import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';

class UserProfileModel extends StatelessWidget {
  const UserProfileModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
                  children: [
              Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor30,
                        boxShadow: ContainerShadow.boxShadow),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.textColor,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://static.vecteezy.com/system/resources/thumbnails/021/690/601/small/bright-sun-shines-on-green-morning-grassy-meadow-bright-blue-sky-ai-generated-image-photo.jpg'),
                                  radius: 50,
                                )),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          alignment: Alignment.topLeft,
                                          child: Text('Harrybaba',
                                              style: nameText())),
                                      Container(
                                          alignment: Alignment.topLeft,
                                          margin: EdgeInsets.only(top: 6),
                                          child: Text('@Harrybaba',
                                              style: usernameText()))
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text('Rank', style: userSubText()),
                                      SizedBox(width: 6),
                                      Text('1st', style: userValueText()),
                                      SizedBox(width: 20),
                                      Text('Points', style: userSubText()),
                                      SizedBox(width: 6),
                                      Text('400', style: userValueText()),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 14),
                        Text(
                            'I Bring innovative ideas to life as a Mobile App Developer. Android & Flutter developer Programming Enthusiast CSE Student',
                            style: userBioText())
                      ],
                    ),
                  ),
                  ],
                ),
    );
  }
}