import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_profile_model.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: SafeArea(
            child: Container(
                    alignment: Alignment.centerLeft,
                    margin:
                        EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                    child: Text('Profile', style: MainFonts.pageTitleText()),
                  ),
          )
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverStickyHeader(
                  sticky: false,
                  header: UserProfileModel(
                      profileUrl: 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png', name: 'Henry Tyson', username: 'henrytyson', rank: 1, points : 400, bio : 'I Bring innovative ideas to life as a Mobile App Developer. Android & Flutter developer Programming Enthusiast CSE Student'
                    )
                ),
              ];
            },
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 100, left: 20, right: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 2,
                              childAspectRatio: (100 / 158)),
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewModel(
                            reviewId: 1,
                            imageUrl:
                                'https://static.vecteezy.com/system/resources/thumbnails/021/690/601/small/bright-sun-shines-on-green-morning-grassy-meadow-bright-blue-sky-ai-generated-image-photo.jpg',
                            price: '100',
                            isLiked: true,
                            title: 'Apple iPhone 14 Pro',
                            brand: 'Apple',
                            category: 'Smart Phones',
                            date: '12/04/2023',
                            rating: 3);
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
