import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/custom_rich_text.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';

class NotificationModel extends StatefulWidget {
  final String message;
  final String msgType;
  final String ago;

  const NotificationModel(
      {super.key,
      required this.message,
      required this.msgType,
      required this.ago,
      });

  @override
  State<NotificationModel> createState() => _NotificationModelState();
}

class _NotificationModelState extends State<NotificationModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppBoarderRadius.userModelRadius)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   backgroundImage: NetworkImage(widget.profileUrl),
                //   radius: 14,
                // ),
                widget.msgType.contains('like') ? Image.asset('assets/icons/like-fill.png',
                    color: AppColors.heartColor,
                    height: 30,
                    width: 30) : widget.msgType.contains('reply') ? Image.asset('assets/icons/reply-fill.png',
                    color: AppColors.secondaryColor10,
                    height: 30,
                    width: 30) : widget.msgType.contains('rank') ? Image.asset('assets/icons/rank-fill.png',
                    color: AppColors.starColor,
                    height: 30,
                    width: 30) : Image.asset('assets/icons/user.png',
                    color: AppColors.iconLighterColor,
                    height: 30,
                    width: 30),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: CustomRichText.buildTextSpan((widget.message.length > 50 ? ('${widget.message.substring(0, 49)}..') : widget.message).split(RegExp(r'(?<=\s|\n)')), MainFonts.postMainText(size: 16), MainFonts.postMainText(size: 16, color: AppColors.secondaryColor10))),
                    SizedBox(height: 6),
                    Text(timePassed(DateTime.parse(widget.ago), full: false), style: MainFonts.miniText(
                        fontSize: 11, color: AppColors.lightTextColor))
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.close_rounded, size: 16, color: AppColors.iconColor,)
        ],
      ),
    );
  }
}
