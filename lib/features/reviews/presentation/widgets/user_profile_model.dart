import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/main.dart';

import '../../../../constants/color.dart';
import '../../../../constants/cryptography.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import 'image_shimmer.dart';

class UserProfileModel extends StatefulWidget {
  final bool hideEditBtn;
  final String profileUrl;
  final String username;
  final String email;
  final String gender;
  final int rank;
  final int score;
  final String bio;

  const UserProfileModel(
      {super.key,
      this.hideEditBtn = false,
      required this.profileUrl,
      required this.username,
      required this.email,
      required this.gender,
      required this.rank,
      required this.score,
      required this.bio});

  @override
  State<UserProfileModel> createState() => _UserProfileModelState();
}

class _UserProfileModelState extends State<UserProfileModel> {
  String getDepartment() {
    if(widget.email.isEmpty || widget.email == null){
      return '';
    }
    return getDepartmentFromEmail(widget.email.contains(AppValues.defaultEmailFormat) ? widget.email : CryptographyConfig.decryptText(widget.email, CryptographyConfig.key, CryptographyConfig.iv)).toUpperCase();
  }
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
                          radius: 35,
                          child: ClipOval(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: AppColors.transparentComponentColor,
                              child: Icon(Icons.person, color: AppColors.lightTextColor, size: 50,),
                            ),
                          ),
                        )
                            : CircleAvatar(
                          backgroundColor: Colors.transparent,
                                radius: 35,
                                child: ClipOval(
                                    child: CustomImageShimmer(
                                        imageUrl: widget.profileUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover)),
                              )),
                    widget.hideEditBtn ? SizedBox() : Container(
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
                        onPressed: () {
                          Navigator.of(context).pushNamed('editprofile');
                        },
                        child: Text('Edit Profile', style: ProfileUserFonts.editText()),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
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
                        ),
                        SizedBox(width: 6),
                        Container(
                          child: Text('${getDepartment()}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.lightTextColor)),
                        ),
                      ],
                    ),
                    MyApp.ENABLE_LEADERBOARD ? Container(
                      decoration: BoxDecoration(
                          color: AppColors.transparentComponentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0)),
                      padding: EdgeInsets.only(
                          top: 3, bottom: 3, left: 8, right: 8),
                      child: Text('Scores: ${widget.score}',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryColor30)),
                    ) : SizedBox()
                  ],
                ),
                SizedBox(height: 8),
                widget.bio.isEmpty ? SizedBox(height: 0) : Text(widget.bio,maxLines: 2,
                    overflow: TextOverflow.ellipsis, style: ProfileUserFonts.userBioText()),
                SizedBox(height: 16)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
