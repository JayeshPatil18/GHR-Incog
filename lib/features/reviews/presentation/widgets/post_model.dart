import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/utils/methods.dart';

import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import 'line.dart';

class PostModel extends StatefulWidget {
  const PostModel({super.key});

  @override
  State<PostModel> createState() => _PostModelState();
}

class _PostModelState extends State<PostModel> {
  int postModelTextMaxLines = 6;
  bool showMore = false;

  String textTest = '"Hey everyone, I wanted to start a discussion on the current state of the stock market. It\'s been a pretty wild ride lately, with lots of ups and downs. I\'m curious to hear everyone\'s thoughts on what\'s driving the market, and what we can expect in the coming weeks and months.';
  @override
  Widget build(BuildContext context) {
    final maxLines = showMore ? 100 : postModelTextMaxLines;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://i.insider.com/61e9ac1cda4bc600181aaf63?width=700'),
                  radius: 18,
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
                            Text('Usernamedfsdfsdfsdjjdfdjff'.length > 20 ? 'Usernamedfsdfsdfsdjjdfdjff'.substring(0, 20) + '...' : 'Usernamedfsdfsdfsdjjdfdjff' , style: MainFonts.lableText(fontSize: 16, weight: FontWeight.w500)),
                            SizedBox(width: 6),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.transparentComponentColor,
                                  borderRadius:
                                  BorderRadius.circular(3.0)
                              ),
                              padding: EdgeInsets.only(top: 2, bottom: 2, left: 3.5, right: 3.5),
                              child: Text('M', style: TextStyle(fontSize: 11, color: AppColors.primaryColor30)),
                            )
                          ],
                        ),
                        Text('10 days ago' , style: MainFonts.miniText(fontSize: 11, color: AppColors.lightTextColor)),
                      ],
                    ),
                    SizedBox(height: 10),
                    AutoSizeText(
                      textTest,
                      maxLines: postModelTextMaxLines,
                      style: MainFonts.postMainText(size: 16),
                      minFontSize: 16,
                      overflowReplacement: Column( // This widget will be replaced.
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            textTest,
                            maxLines: maxLines,
                            overflow: TextOverflow.ellipsis,
                              style: MainFonts.postMainText(size: 16)
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showMore = !showMore;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                  showMore ? 'See less' : 'See more',
                                  style: MainFonts.lableText(color: AppColors.secondaryColor10, fontSize: 14, weight: FontWeight.bold)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('assets/icons/reply.png',
                            color: AppColors.primaryColor30,
                            height: 19, width: 19),
                        const SizedBox(width: 4),
                        Text('100', style: MainFonts.postMainText(size: 13)),
                        const SizedBox(width: 40),
                        Image.asset('assets/icons/like.png',
                            color: AppColors.primaryColor30,
                            height: 19, width: 19),
                        const SizedBox(width: 4),
                        Text('100', style: MainFonts.postMainText(size: 12)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Line()
      ],
    );
  }
}
