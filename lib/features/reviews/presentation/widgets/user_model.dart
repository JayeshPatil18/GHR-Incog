import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../domain/entities/id_argument.dart';
import 'image_shimmer.dart';

class UserModel extends StatefulWidget {
  final String profileUrl;
  final String name;
  final String username;
  final int uId;
  final int rank;
  final int points;

  const UserModel(
      {super.key,
      required this.profileUrl,
      required this.name,
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
    return Container(
        margin: EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(AppBoarderRadius.userModelRadius),
            color: AppColors.primaryColor30,
            boxShadow: ContainerShadow.boxShadow),
        child: Container(
          child: ListTile(
            title: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'view_profile', arguments: IdArguments(widget.uId));
              },
              child: Row(
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
                      child: widget.profileUrl == 'null'
                          ? CircleAvatar(
                              backgroundImage: AssetImage("assets/icons/user.png"),
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
                  SizedBox(width: 20),
                  Flexible(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: UserModelFonts.userRankingTitle(),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '@${widget.username}',
                            style: UserModelFonts.userRankingSubTitle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(suffixOfNumber(widget.rank),
                    style: UserModelFonts.userRankingTitle()),
                SizedBox(height: 6),
                Text('Pts. ${widget.points}',
                    style: UserModelFonts.userRankingSubTitle()),
              ],
            ),
            contentPadding:
                EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
            onTap: () {},
            onLongPress: () {},
          ),
        ));
  }
}
