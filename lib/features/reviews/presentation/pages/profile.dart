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
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: UsersRepo.userFireInstance.snapshots(),
                  builder: (context, snapshot) {
                    final documents;
                    if (snapshot != null) {
                      documents = snapshot.data?.docs;
                      List<Map<String, dynamic>> usersData = [];
                      User? user;

                      if (documents != null && documents.isNotEmpty) {
                        final firstDocument = documents[0];

                        if (firstDocument != null &&
                            firstDocument.data() != null &&
                            firstDocument.data().containsKey('userslist')) {
                          usersData = List<Map<String, dynamic>>.from(
                              firstDocument.data()['userslist']);

                          List<User> usersList = usersData
                              .map((userData) => User.fromMap(userData))
                              .toList();

                          List<User> users = usersList
                              .where((user) => user.uid == MyApp.userId)
                              .toList();
                          user = users.first;
                        }
                      }

                      return SliverAppBar(
                        elevation: 0.0,
                          pinned: false,
                          floating: false,
                          automaticallyImplyLeading: false,
                          expandedHeight: height,
                          backgroundColor: AppColors.backgroundColor60,
                          flexibleSpace: FlexibleSpaceBar(
                            title: const SizedBox(),
                          background: UserProfileModel(
                            profileUrl: user?.profileUrl ?? 'null',
                            name: user?.fullName ?? '',
                            username: user?.username ?? '',
                            rank: user?.rank ?? -1,
                            points: user?.points ?? -1,
                            bio: user?.bio ?? '',
                          )));
                    } else {
                      return Container(
                          height: 400,
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }),
            ];
          },
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: ReviewRepo.reviewFireInstance
                          .where('userId', isEqualTo: MyApp.userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        final documents;
                        if (snapshot.data != null) {
                          documents = snapshot.data!.docs;
                          if (documents.length < 1) {
                            return Center(
                                child: Text('No Reviews',
                                    style: MainFonts.filterText(
                                        color: AppColors.textColor)));
                          }
                          return GridView.builder(
                              padding: EdgeInsets.only(
                                  top: 10, bottom: 100, left: 20, right: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      crossAxisCount: 2,
                                      childAspectRatio: (100 / 158)),
                              scrollDirection: Axis.vertical,
                              itemCount: documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                UploadReviewModel review =
                                    UploadReviewModel.fromMap(documents[index]
                                        .data() as Map<String, dynamic>);

                                return ReviewModel(
                                    reviewId: review.rid,
                                    imageUrl: review.imageUrl,
                                    price: review.price,
                                    isLiked:
                                        review.likedBy.contains(MyApp.userId),
                                    title: review.name,
                                    brand: review.brand,
                                    category: review.category,
                                    date: review.date
                                        .substring(0, 10)
                                        .replaceAll('-', '/'),
                                    rating: review.rating);
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
