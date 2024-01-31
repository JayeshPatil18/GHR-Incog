import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:review_app/features/reviews/presentation/widgets/user_profile_model.dart';
import 'package:review_app/main.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../../../authentication/data/repositories/users_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/tabs_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ScrollController _scrollController = ScrollController();
  bool lastStatus = true;
  double height = 200;

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Text('Profile', style: MainFonts.pageTitleText()),
              ),
            )),
        body: DefaultTabController(
          length: 3,
          child: RefreshIndicator(
            onRefresh: () async {
              // _refresh();
            },
            child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      UserProfileModel(profileUrl: 'profileUrl', name: 'name', username: 'username', rank: 1, points: 1, bio: 'bio'),
                    ]),
                  )
                ];
              },
              body: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.transparentComponentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: TabBar(
                                indicator: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                tabs: [
                                  Tab(
                                    text: "Post",
                                  ),
                                  Tab(
                                    text: "Comments",
                                  ),
                                  Tab(
                                    text: "Likes",
                                  ),
                                ]),
                          ),
                          Container(
                            color: Colors.grey,
                            height: 0.3,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [TweetsTab(), RepliesTab(), LikesTab()],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
