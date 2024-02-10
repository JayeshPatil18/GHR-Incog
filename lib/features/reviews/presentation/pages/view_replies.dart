import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/line.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/utils/dropdown_items.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../bloc/upload_review/upload_review_bloc.dart';
import '../bloc/upload_review/upload_review_event.dart';
import '../widgets/dropdown.dart';
import '../widgets/post_model.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/view_post_model.dart';
import '../widgets/view_replies_model.dart';

class ViewReplies extends StatefulWidget {
  final String postId;
  const ViewReplies({super.key, required this.postId});

  @override
  State<ViewReplies> createState() => _ViewRepliesState();
}

class _ViewRepliesState extends State<ViewReplies> {
  final FocusNode _focusPostTextNode = FocusNode();
  bool _hasPostTextFocus = false;
  TextEditingController postTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int hasImagePicked = -1;

  String? _validateInput(String? input, int index) {
    if (input != null) {
      input = input.trim();
    }

    switch (index) {
      case 0:
        if ((input == null || input.isEmpty) && _selectedMedia == null) {
          return 'Write confession';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _focusPostTextNode.addListener(() {
      setState(() {
        _hasPostTextFocus = _focusPostTextNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  File? _selectedMedia;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    setState(() {
      hasImagePicked = 1;
      _selectedMedia = File(image.path);
    });
  }

  double progress = 0;
  int currentCharacters = 0;

  _onTextChanged(){
    setState(() {
      currentCharacters = postTextController.text.length;
      progress = currentCharacters / AppValues.maxCharactersPost;
    });
  }

  @override
  Widget build(BuildContext context) {
    _onTextChanged();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin:
                EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios,
                              color: AppColors.textColor, size: 20),
                        ),
                        SizedBox(width: 10),
                        Text('View Replies', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: ReviewRepo.reviewFireInstance.orderBy('date', descending: true).snapshots(),
                    builder: (context, snapshot) {
                      final documents;
                      if (snapshot.data != null) {
                        documents = snapshot.data!.docs;

                        UploadReviewModel? postOfReplies;
                        List<UploadReviewModel> documentList = [];
                        List<UploadReviewModel> postsList = [];

                        // Getting comment count
                        int commentCount = 0;
                        bool isCommented = false;

                        for(int i = 0; i < documents.length; i++){
                          UploadReviewModel post = UploadReviewModel.fromMap(documents[i].data() as Map<String, dynamic>);
                          documentList.add(post);

                          if(post.postId == widget.postId){
                            postOfReplies = post;
                          } else if(post.parentId == widget.postId){
                            postsList.add(post);
                          }

                          if(widget.postId == post.parentId){
                            if(MyApp.userId == post.userId){
                              isCommented = true;
                            }
                            commentCount++;
                          }
                        }

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ViewPostModel(
                                commentCount: commentCount,
                                isCommented: isCommented,
                                date: postOfReplies?.date ?? '',
                                likedBy: postOfReplies?.likedBy ?? [],
                                mediaUrl: postOfReplies?.mediaUrl ?? '',
                                gender: postOfReplies?.gender ?? '',
                                userProfileUrl: postOfReplies?.userProfileUrl ?? '',
                                parentId: postOfReplies?.parentId ?? '',
                                postId: postOfReplies?.postId ?? '',
                                text: postOfReplies?.text ?? '',
                                userId: postOfReplies?.userId ?? -1,
                                username: postOfReplies?.username ?? '',
                              ),
                              postsList.isNotEmpty ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 100, top: 20),
                                  itemCount: postsList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    UploadReviewModel post = postsList[index];

                                    int commentCount = 0;
                                    bool isCommented = false;
                                    for(UploadReviewModel i in documentList){
                                      if(post.postId == i.parentId){
                                        if(MyApp.userId == i.userId){
                                          isCommented = true;
                                        }
                                        commentCount++;
                                      }

                                    }

                                    return RepliesModel(
                                      commentCount: commentCount,
                                      isCommented: isCommented,
                                      date: post.date,
                                      likedBy: post.likedBy,
                                      mediaUrl: post.mediaUrl,
                                      gender: post.gender,
                                      userProfileUrl: post.userProfileUrl,
                                      parentId: post.parentId,
                                      postId: post.postId,
                                      text: post.text,
                                      userId: post.userId,
                                      username: post.username,
                                    );
                                  }) : Container(
                                  margin: EdgeInsets.only(top: 40), child: Center(child: Text('No Replies', style: MainFonts.filterText(color: AppColors.lightTextColor)))),
                            ],
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}