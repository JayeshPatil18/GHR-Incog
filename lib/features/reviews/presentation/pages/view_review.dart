import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/utils/fonts.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/icon_size.dart';
import '../../../../constants/values.dart';
import '../widgets/circle_button.dart';

class ViewReview extends StatefulWidget {
  const ViewReview({super.key});

  @override
  State<ViewReview> createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, 'login');
                              },
                              child: Icon(Icons.arrow_back_ios,
                                  color: AppColors.textColor, size: 26),
                            ),
                            CircleIconContainer(
                              containerColor: AppColors.backgroundColor60,
                              containerSize: 44,
                              icon: Icon(Icons.favorite_border,
                                  color: AppColors.primaryColor30, size: 28),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: ContainerShadow.boxShadow),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.reviewUploadRadius),
                              child: Image.network(
                                  width:
                                      (MediaQuery.of(context).size.width) - 80,
                                  height:
                                      (MediaQuery.of(context).size.width) - 80,
                                  'https://static.vecteezy.com/system/resources/thumbnails/021/690/601/small/bright-sun-shines-on-green-morning-grassy-meadow-bright-blue-sky-ai-generated-image-photo.jpg',
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      boxShadow: [ContainerShadow.boxShadow[1]],
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(AppBoarderRadius.reviewUploadRadius),
                        topRight:
                            Radius.circular(AppBoarderRadius.reviewUploadRadius),
                      ),
                      color: AppColors.primaryColor30,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('boAt Rockerz 558', style: ViewReviewFonts.titleText()),
                              Row(children: [
                                Text('\$',
                                    style: ViewReviewFonts.titleText(
                                        color: AppColors.secondaryColor10)),
                                Text('1000', style: ViewReviewFonts.titleText())
                              ]),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Row(
                            children: [
                              Text('Boat', style: ViewReviewFonts.subTitleText()),
                              Text('  ○  ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textColor)),
                              Text('Headphones', style: ViewReviewFonts.subTitleText()),
                            ],
                          ),
                          Text('12/04/2023', style: ViewReviewFonts.subTitleText())
                          ]),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 24,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: AppValues.maxRating,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Row(
                                        children: [
                                          Icon(Icons.star,
                                              size: 24,
                                              color: index < 4
                                                  ? AppColors.starColor
                                                  : AppColors.iconLightColor),
                                          SizedBox(width: 2)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Text('@harrymarsh', style: ViewReviewFonts.reviewUserText())
                            ],
                          ),
                          SizedBox(height: 20),
                          Text('Description', style: ViewReviewFonts.contentLabelText()),
                          SizedBox(height: 8),
                          Text('The details that you provide for a product affect the way that the product is displayed to customers, make it easier for you to organize your products', style: ViewReviewFonts.contentText(),),
                          SizedBox(height: 20),
                          Text('Summary', style: ViewReviewFonts.contentLabelText()),
                          SizedBox(height: 8),
                          Text('Well Protected Good experience soundPacking also goodIt will be more better When it work on price should approx 1700.Overall its a Good Product', style: ViewReviewFonts.contentText(),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ));
  }
}
