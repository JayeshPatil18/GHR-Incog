import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/domain/entities/id_argument.dart';
import 'package:review_app/utils/methods.dart';

import '../../../../constants/color.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/string_argument.dart';
import 'image_shimmer.dart';
import 'line.dart';

class ViewPostModel extends StatefulWidget {
  final int commentCount;
  final bool isCommented;
  final String date;
  final List<int> likedBy;
  final String mediaUrl;
  final String userProfileUrl;
  final String gender;
  final String parentId;
  final String postId;
  final String text;
  final int userId;
  final String username;

  const ViewPostModel({
    super.key,
    required this.commentCount,
    required this.isCommented,
    required this.date,
    required this.likedBy,
    required this.mediaUrl,
    required this.userProfileUrl,
    required this.gender,
    required this.parentId,
    required this.postId,
    required this.text,
    required this.userId,
    required this.username,
  });

  @override
  State<ViewPostModel> createState() => _ViewPostModelState();
}

class _ViewPostModelState extends State<ViewPostModel> {
  int postModelTextMaxLines = 6;
  bool showMore = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    child: widget.userProfileUrl == 'null' || widget.userProfileUrl.isEmpty
                        ? CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 18,
                      child: ClipOval(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: AppColors.transparentComponentColor,
                          child: Icon(Icons.person, color: AppColors.lightTextColor,),
                        ),
                      ),
                    ) : CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 18,
                      child: ClipOval(
                          child: CustomImageShimmer(
                              imageUrl: widget.userProfileUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                    widget.username.length > 20
                                        ? widget.username.substring(0, 20) + '...'
                                        : widget.username,
                                    style: MainFonts.lableText(
                                        fontSize: 16, weight: FontWeight.w500)),
                                SizedBox(width: 6),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.transparentComponentColor,
                                      borderRadius: BorderRadius.circular(3.0)),
                                  padding: EdgeInsets.only(
                                      top: 2, bottom: 2, left: 3.5, right: 3.5),
                                  child: Text(widget.gender.isNotEmpty ? widget.gender[0].toUpperCase() : ' - ',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: AppColors.primaryColor30)),
                                )
                              ],
                            ),
                            Text(widget.date.substring(0, 10).replaceAll('-', '/'),
                                style: MainFonts.miniText(
                                    fontSize: 11, color: AppColors.lightTextColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              widget.text.isEmpty ? SizedBox() : Column(
                children: [
                  SizedBox(height: 16),
                  AutoSizeText(
                    widget.text,
                    maxLines: postModelTextMaxLines,
                    style: MainFonts.postMainText(size: 16),
                    minFontSize: 16,
                    overflowReplacement: Column(
                      // This widget will be replaced.
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.text,
                            overflow: TextOverflow.ellipsis,
                            style: MainFonts.postMainText(size: 16)),
                      ],
                    ),
                  ),
                ],
              ),
              widget.mediaUrl == 'null' || widget.mediaUrl.isEmpty ? SizedBox(height: 0) : Column(
                children: [
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pushNamed(context, 'view_image', arguments: ImageViewArguments(widget.mediaUrl , true));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 260,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomImageShimmer(
                              imageUrl: widget.mediaUrl,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  Container(
                    child: widget.isCommented ? Image.asset('assets/icons/reply-fill.png',
                        color: AppColors.secondaryColor10,
                        height: 19,
                        width: 19) : Image.asset('assets/icons/reply.png',
                        color: AppColors.primaryColor30,
                        height: 19,
                        width: 19),
                  ),
                  const SizedBox(width: 5),
                  Text(widget.commentCount.toString(), style: MainFonts.postMainText(size: 13)),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      ReviewRepo reviewRepo = ReviewRepo();
                      reviewRepo.likeReview(widget.postId, widget.likedBy.contains(MyApp.userId));
                    },
                    child: Row(
                      children: [
                        Container(
                          child: widget.likedBy.contains(MyApp.userId) ? Image.asset('assets/icons/like-fill.png',
                              color: AppColors.heartColor,
                              height: 19,
                              width: 19) : Image.asset('assets/icons/like.png',
                              color: AppColors.primaryColor30,
                              height: 19,
                              width: 19),
                        ),
                        const SizedBox(width: 5),
                        Text(widget.likedBy.length.toString(),
                            style: MainFonts.postMainText(size: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Line(),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, top: 20, bottom: 10),
          child: Text('${widget.commentCount} Comments', style: MainFonts.pageTitleText(fontSize: 20, weight: FontWeight.w500)),
        )
      ],
    );
  }
}
