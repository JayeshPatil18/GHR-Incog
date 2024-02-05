import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../../authentication/data/repositories/users_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/line.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/user_model.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  static String searchText = '';

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {

  TextEditingController searchTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    MyApp.initUserId();
    super.initState();

    _focusNode.addListener(() {
      setState(() {
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    MyApp.initUserId();
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(72),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 16, left: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            textInputAction: TextInputAction.search,
                            textAlignVertical: TextAlignVertical.center,
                            style: MainFonts.searchText(color: AppColors.primaryColor30),
                            focusNode: _focusNode,
                            controller: searchTextController,
                            onChanged: (value) {
                              setState(() {
                                LikedPage.searchText =
                                    value.trim().toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 2, bottom: 2),
                              fillColor: AppColors.transparentComponentColor,
                              filled: true,
                              hintText: 'Search Posts, Profiles',
                              hintStyle: MainFonts.searchText(color: AppColors.transparentComponentColor),
                              prefixIcon: Icon(Icons.search_rounded, color: AppColors.transparentComponentColor,),
                              suffixIcon: LikedPage.searchText == "" ? null : GestureDetector(
                                  onTap: () {
                                    searchTextController.text = '';
                                    setState(() {
                                      LikedPage.searchText = '';
                                    });
                                  },
                                  child: Icon(Icons.cancel_rounded, color: AppColors.transparentComponentColor,)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    18),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        _focusNode.hasFocus ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: GestureDetector(
                              onTap: () {
                                _focusNode.unfocus();
                              },
                              child: Text('Cancel', style: MainFonts.searchText(color: AppColors.primaryColor30))),
                        ) : SizedBox()
                      ],
                    ),
                  ),
                  Line()
                ],
              ),
            )),
      backgroundColor: Colors.transparent,
      body: _focusNode.hasFocus ? SizedBox() : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
              child: Text('Top Scores', style: MainFonts.pageTitleText(fontSize: 22)),
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: UsersRepo.userFireInstance.snapshots(),
                  builder: (context, snapshot) {
                    final documents;
                    if (snapshot.data != null) {
                      documents = snapshot.data!.docs;
                      List<Map<String, dynamic>> usersData =
                      List<Map<String, dynamic>>.from(
                          documents[0].data()['userslist']);

                      List<User> usersList = usersData
                          .map((userData) => User.fromMap(userData))
                          .toList();

                      usersList.sort((a, b) => a.rank.compareTo(b.rank));

                      if (usersList.length < 1) {
                        return Center(
                            child: Text('No Users',
                                style: MainFonts.filterText(
                                    color: AppColors.textColor)));
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: 10, left: 14, right: 14, bottom: 90),
                        itemCount: usersList.length,
                        itemBuilder: (context, index) {
                          User user = usersList[index];

                          return UserModel(
                              uId: user.uid,
                              profileUrl: user.profileUrl,
                              username: user.username,
                              rank: user.rank,
                              points: user.score);
                        },
                      );
                    } else {
                      return Container(
                          margin: EdgeInsets.only(top: 80),
                          child: Center(child: CircularProgressIndicator()));
                    }
                  }),
            ),
          ],
        ),
      )
    );
  }
}