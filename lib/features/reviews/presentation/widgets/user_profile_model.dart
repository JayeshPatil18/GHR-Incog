import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/main.dart';

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
                                backgroundImage:
                                    AssetImage("assets/icons/user.png"),
                                radius: 40,
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
                      color: Colors.grey,
                      child: OutlinedButton(
                        onPressed: () {  },
                        child: Text('Edit Profile'),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12),
                Text(widget.name,
                    style: ProfileUserFonts.usernameText()),
                SizedBox(height: 6),
                Text(widget.bio,maxLines: 2,
                    overflow: TextOverflow.ellipsis, style: ProfileUserFonts.userBioText())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
