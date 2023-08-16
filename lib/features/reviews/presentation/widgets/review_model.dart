import 'dart:ffi';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/constants/boarder.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/utils/fonts.dart';

import '../../../../constants/values.dart';

class ReviewModel extends StatefulWidget {
  final String imageUrl;
  final String price;
  final bool isLiked;
  final String title;
  final String brand;
  final String category;
  final String date;
  final int rating;

  const ReviewModel({
    required this.imageUrl,
    required this.price,
    required this.isLiked,
    required this.title,
    required this.brand,
    required this.category,
    required this.date,
    required this.rating,
  });

  @override
  State<ReviewModel> createState() => _ReviewModelState();
}

class _ReviewModelState extends State<ReviewModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor30,
          borderRadius:
              BorderRadius.circular(AppBoarderRadius.reviewModelRadius),
          boxShadow: ContainerShadow.boxShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(
                        AppBoarderRadius.reviewModelImageRadius),
                    child: widget.imageUrl == null
                        ? SizedBox(width: 156, height: 156)
                        : Image.network(widget.imageUrl, fit: BoxFit.cover)),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Row(
                    children: [
                      Text('\u{20B9}',
                          style: subReviewPrice(
                              color: AppColors.secondaryColor10,
                              boxShadow: TextShadow.textShadow)),
                      Text(widget.price,
                          style:
                              subReviewPrice(boxShadow: TextShadow.textShadow)),
                    ],
                  ),
                ),
                Positioned(
                    top: 8,
                    right: 8,
                    child: widget.isLiked
                        ? Icon(
                            Icons.favorite,
                            color: AppColors.heartColor,
                            shadows: [TextShadow.textShadow],
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: AppColors.primaryColor30,
                            shadows: [TextShadow.textShadow],
                          ))
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    Text(widget.title, style: reviewTitle()),
                    SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.brand, style: reviewSubTitle()),
                        Text('  ○  ',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor)),
                        Text(widget.category, style: reviewSubTitle()),
                      ],
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.date, style: dateReview()),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 16,
                    child: ListView.builder(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: AppValues.maxRating,
                      itemBuilder: (BuildContext context, int index) {
                        return Icon(Icons.star,
                            size: 16,
                            color: index < AppValues.maxRating - widget.rating
                                ? AppColors.iconColor
                                : AppColors.starColor);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
