import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';

class NotificationModel extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String username;
  final int rank;
  final int points;

  const NotificationModel(
      {super.key,
      required this.profileUrl,
      required this.name,
      required this.username,
      required this.rank,
      required this.points});

  @override
  State<NotificationModel> createState() => _NotificationModelState();
}

class _NotificationModelState extends State<NotificationModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBoarderRadius.userModelRadius),
          color: AppColors.primaryColor30,
          boxShadow: ContainerShadow.boxShadow),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text('10 min ago', style: NotificationFonts.agoText())),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Container(
                          width: 35,
                          height: 35,
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
                          )),
                      SizedBox(width: 20),
                      Flexible(
                        child: Text(
                          widget.name,
                          style: NotificationFonts.messageText(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
             alignment: Alignment.bottomRight,
            child: Icon(Icons.close, size: 16))
        ],
      ),
    );
  }
}
