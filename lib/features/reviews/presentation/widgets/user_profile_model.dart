import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import 'image_shimmer.dart';

class UserProfileModel extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String username;
  final int rank;
  final int points;
  final String bio;

  const UserProfileModel(
      {super.key,
      required this.profileUrl,
      required this.name,
      required this.username,
      required this.rank,
      required this.points,
      required this.bio});

  @override
  State<UserProfileModel> createState() => _UserProfileModelState();
}

class _UserProfileModelState extends State<UserProfileModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.secondaryColor10,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20.9),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primaryColor30,
                    AppColors.primaryColor30,
                  ],
                ),
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
                        child: widget.profileUrl == null ||
                                widget.profileUrl == 'null'
                            ? CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/icons/user.png"),
                                radius: 50,
                              )
                            : CircleAvatar(
                                radius: 50,
                                child: ClipOval(
                                    child: CustomImageShimmer(
                                        imageUrl: widget.profileUrl,
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover)),
                              )),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(widget.name,
                                      style: ProfileUserFonts.nameText())),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text('@${widget.username}',
                                      style: ProfileUserFonts.usernameText()))
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Rank',
                                  style: ProfileUserFonts.userSubText()),
                              SizedBox(width: 6),
                              Text('_', // suffixOfNumber(widget.rank),
                                  style: ProfileUserFonts.userValueText()),
                              SizedBox(width: 20),
                              Text('Points',
                                  style: ProfileUserFonts.userSubText()),
                              SizedBox(width: 6),
                              Text('_', // widget.points.toString(),
                                  style: ProfileUserFonts.userValueText()),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 14),
                Text(widget.bio, style: ProfileUserFonts.userBioText())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
