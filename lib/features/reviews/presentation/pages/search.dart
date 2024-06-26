import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';

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
import '../widgets/dialog_box.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/line.dart';
import '../widgets/review_model.dart';
import '../widgets/search_tabs.dart';
import '../widgets/shadow.dart';
import '../widgets/user_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static String searchText = '';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchTextController = TextEditingController();
  static final FocusNode _focusNode = FocusNode();

  bool _showSearchResults = false;
  
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
    return WillPopScope(
    onWillPop: _onWillPop,
      child: Scaffold(
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
                            child: TextField(
                              textInputAction: TextInputAction.search,
                              onSubmitted: (String query) {
                                setState(() {
                                  _showSearchResults = true;
                                });
                              },
                              textAlignVertical: TextAlignVertical.center,
                              style: MainFonts.searchText(color: AppColors.primaryColor30),
                              focusNode: _focusNode,
                              controller: searchTextController,
                              onChanged: (value) {
                                setState(() {
                                  SearchPage.searchText =
                                      value.trim().toLowerCase();
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 2, bottom: 2),
                                fillColor: AppColors.transparentComponentColor.withOpacity(0.1/2),
                                filled: true,
                                hintText: 'Search Posts, Profiles',
                                hintStyle: MainFonts.searchText(color: AppColors.transparentComponentColor),
                                prefixIcon: Icon(Icons.search_rounded, color: AppColors.transparentComponentColor,),
                                suffixIcon: SearchPage.searchText == "" ? null : GestureDetector(
                                    onTap: () {
                                      searchTextController.text = '';
                                      setState(() {
                                        SearchPage.searchText = '';
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
        body: _showSearchResults ? SearchResultPage() : TopScoresList()
      ),
    );
  }

  Future<bool> _onWillPop() async {

    if(_showSearchResults){
      setState(() {
        _showSearchResults = false;
      });
      return false;
    }
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return CustomDialogBox(title: Text('Are you sure you want to exit?', style: TextStyle(fontSize: 18)), content: null, textButton1: TextButton(
            child: Text('Yes, exit', style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ), textButton2: TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ));
        }
    );
    return value != null ? value : false;
  }
}
class SearchResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.transparentComponentColor.withOpacity(0.1/2),
                      borderRadius: BorderRadius.circular(10)),
                  child: TabBar(
                      indicator: BoxDecoration(
                          color: AppColors.transparentComponentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)),
                      labelColor: AppColors.primaryColor30,
                      labelStyle: MainFonts.searchText(weight: FontWeight.w500, size: 15),
                      unselectedLabelColor: AppColors.lightTextColor,
                      tabs: [
                        Tab(
                          text: "Posts",
                        ),
                        Tab(
                          text: "Profiles",
                        ),
                      ]),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [PostsTab(), ProfilesTab()],
              ),
            ),
          ]
      ),
    );
  }
}

class TopScoresList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _SearchPageState._focusNode.hasFocus ? SizedBox() : SingleChildScrollView(
      child: MyApp.ENABLE_LEADERBOARD ? Column(
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

                    // Sort order according to rank
                    usersList.sort((a, b) => a.rank.compareTo(b.rank));

                    if (usersList.length < 1) {
                      return Center(
                          child: Text('No Users',
                              style: MainFonts.filterText(
                                  color: AppColors.lightTextColor)));
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
      ) : SizedBox(),
    );
  }
}