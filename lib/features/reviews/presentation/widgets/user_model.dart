import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../domain/entities/id_argument.dart';
import 'image_shimmer.dart';

class UserModel extends StatefulWidget {
  final String profileUrl;
  final String username;
  final int uId;
  final int rank;
  final int points;

  const UserModel(
      {super.key,
      required this.profileUrl,
      required this.username,
      required this.uId,
      required this.rank,
      required this.points});

  @override
  State<UserModel> createState() => _UserModelState();
}

class _UserModelState extends State<UserModel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: MyApp.ENABLE_LEADERBOARD ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Container(
                  child: widget.profileUrl == 'null' || widget.profileUrl.isEmpty
                      ? CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 25,
                    child: ClipOval(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.transparentComponentColor,
                        child: Icon(Icons.person, color: AppColors.lightTextColor, size: 35),
                      ),
                    ),
                  ) : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 25,
                    child: ClipOval(
                        child: CustomImageShimmer(
                            imageUrl: widget.profileUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                            widget.username.length > 20
                                ? widget.username.substring(0, 20) + '...'
                                : widget.username,
                            style: MainFonts.lableText(
                                fontSize: 17, weight: FontWeight.w500)),
                        SizedBox(width: 6),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.transparentComponentColor,
                              borderRadius: BorderRadius.circular(3.0)),
                          padding: EdgeInsets.only(
                              top: 2, bottom: 2, left: 3.5, right: 3.5),
                          child: Center(
                            child: Text('male'.isNotEmpty ? 'male'[0].toUpperCase() : ' - ',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.primaryColor30)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    MyApp.ENABLE_LEADERBOARD ? Container(
                      decoration: BoxDecoration(
                          color: AppColors.transparentComponentColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.only(
                          top: 3, bottom: 3, left: 8, right: 8),
                      child: Text('Scores: ${widget.points}',
                          style: TextStyle(
                              fontSize: 10,
                              color: AppColors.primaryColor30)),
                    ) : SizedBox()
                  ],
                ),
              ],
            ),
            MyApp.ENABLE_LEADERBOARD ? Text('#${widget.rank}',
                style: MainFonts.lableText(
                    fontSize: 17, weight: FontWeight.w500)) : SizedBox(),
          ],
        ),
        SizedBox(height: 35)
      ],
    );
  }
}
