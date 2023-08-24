import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/notification_model.dart';

import '../../../../constants/boarder.dart';
import '../../../../utils/fonts.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/user_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor60,
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
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios,
                              color: AppColors.textColor, size: 26),
                        ),
                        SizedBox(width: 10),
                      Text('Notifications', style: MainFonts.pageTitleText()),
                    ],
                  ),
                  Container(
                        decoration: BoxDecoration(
                          boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.textColor,
                          borderRadius: BorderRadius.circular(
                              AppBoarderRadius.filterRadius),
                        ),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 13, right: 13),
                        child: Text('Clear All',
                            style: MainFonts.filterText(color: AppColors.primaryColor30)),
                      ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 90),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return NotificationModel(profileUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', name: 'Henry Tyson', username: 'henrytyson', rank: index + 1, points : 400);
                },
              ),
            )
          ],
        ),
      )
    );
  }
}