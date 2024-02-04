import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/main.dart';

import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import 'image_shimmer.dart';

class UserProfileModel extends StatefulWidget {
  final String profileUrl;
  final String username;
  final String gender;
  final int rank;
  final int score;
  final String bio;

  const UserProfileModel(
      {super.key,
      required this.profileUrl,
      required this.username,
      required this.gender,
      required this.rank,
      required this.score,
      required this.bio});

  @override
  State<UserProfileModel> createState() => _UserProfileModelState();
}

class _UserProfileModelState extends State<UserProfileModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: widget.profileUrl == null ||
                                widget.profileUrl == 'null'
                            ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 40,
                          child: ClipOval(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: AppColors.transparentComponentColor,
                              child: Icon(Icons.person, color: AppColors.lightTextColor, size: 55,),
                            ),
                          ),
                        )
                            : CircleAvatar(
                                radius: 40,
                                child: ClipOval(
                                    child: CustomImageShimmer(
                                        imageUrl: widget.profileUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover)),
                              )),
                    Container(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: const BorderSide(
                            width: 1.2,
                            color: AppColors.textColor,
                          ),
                        ),
                        onPressed: () {  },
                        child: Text('Edit Profile', style: ProfileUserFonts.editText()),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(widget.username,
                            style: ProfileUserFonts.usernameText()),
                        SizedBox(width: 6,),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.transparentComponentColor,
                              borderRadius: BorderRadius.circular(3.0)),
                          padding: EdgeInsets.only(
                              top: 2, bottom: 2, left: 3.5, right: 3.5),
                          child: Text(widget.gender.isNotEmpty ? widget.gender[0].toUpperCase() : ' - ',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primaryColor30)),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.transparentComponentColor,
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.only(
                          top: 3, bottom: 3, left: 8, right: 8),
                      child: Text('Scores: ${widget.score}',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryColor30)),
                    )
                  ],
                ),
                SizedBox(height: 8),
                widget.bio.isEmpty ? SizedBox(height: 0) : Text(widget.bio,maxLines: 2,
                    overflow: TextOverflow.ellipsis, style: ProfileUserFonts.userBioText())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
