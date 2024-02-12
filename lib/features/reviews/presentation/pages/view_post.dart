import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:rich_text_controller/rich_text_controller.dart';

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
import '../../domain/entities/string_argument.dart';
import '../../domain/entities/two_string_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../bloc/upload_review/upload_review_bloc.dart';
import '../bloc/upload_review/upload_review_event.dart';
import '../widgets/dropdown.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/post_model.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/view_post_model.dart';
import '../widgets/view_replies_model.dart';

class ViewPost extends StatefulWidget {
  final String postId;
  const ViewPost({super.key, required this.postId});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final FocusNode _focusPostTextNode = FocusNode();
  bool _hasPostTextFocus = false;
  late RichTextController postTextController;
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

    postTextController = RichTextController(
      patternMatchMap: {
        RegExp(r'@\w+'): MainFonts.searchText(color: AppColors.secondaryColor10),
      },
      onMatch: (List<String> matches) {},
    );

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
                        Text('View Post', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
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
                                padding: EdgeInsets.only(bottom: 100),
                                itemCount: postsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  UploadReviewModel post = postsList[index];
                                  UploadReviewModel? replyOfPoster = null;

                                  int commentCount = 0;
                                  bool isCommented = false;
                                  for(UploadReviewModel i in documentList){
                                    if(post.postId == i.parentId){

                                      if((postOfReplies?.username ?? '') == i.username){
                                        replyOfPoster = post;
                                      }

                                      if(MyApp.userId == i.userId){
                                        isCommented = true;
                                      }
                                      commentCount++;
                                    }

                                  }

                                  int postModelTextMaxLines = 6;
                                  bool showMore = false;

                                  final maxLines = showMore ? 100 : postModelTextMaxLines;

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'view_replies', arguments: TwoStringArg(widget.postId, post.postId));
                                    },
                                    child: replyOfPoster != null ?
                                    Column(
                                      children: [
                                        SizedBox(height: 20),
                                        RepliesModel(
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
                                        ),
                                        // Change for model if reply is more than 1
                                        // And also change Vertical Line for multi line
                                        Column(
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              padding: EdgeInsets.only(left: 10, right: 10, bottom: 16),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: replyOfPoster.userProfileUrl == 'null' || replyOfPoster.userProfileUrl.isEmpty
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
                                                              imageUrl: replyOfPoster.userProfileUrl,
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
                                                                    replyOfPoster.username.length > 20
                                                                        ? replyOfPoster.username.substring(0, 20) + '...'
                                                                        : replyOfPoster.username,
                                                                    style: MainFonts.lableText(
                                                                        fontSize: 16, weight: FontWeight.w500)),
                                                                SizedBox(width: 6),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: AppColors.transparentComponentColor,
                                                                      borderRadius: BorderRadius.circular(3.0)),
                                                                  padding: EdgeInsets.only(
                                                                      top: 2, bottom: 2, left: 3.5, right: 3.5),
                                                                  child: Text(replyOfPoster.gender.isNotEmpty ? replyOfPoster.gender[0].toUpperCase() : ' - ',
                                                                      style: TextStyle(
                                                                          fontSize: 11,
                                                                          color: AppColors.primaryColor30)),
                                                                )
                                                              ],
                                                            ),
                                                            Text(replyOfPoster.date.substring(0, 10).replaceAll('-', '/'),
                                                                style: MainFonts.miniText(
                                                                    fontSize: 11, color: AppColors.lightTextColor)),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        replyOfPoster.text.isEmpty ? SizedBox() : AutoSizeText(
                                                          replyOfPoster.text,
                                                          maxLines: postModelTextMaxLines,
                                                          style: MainFonts.postMainText(size: 16),
                                                          minFontSize: 16,
                                                          overflowReplacement: Column(
                                                            // This widget will be replaced.
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Text(replyOfPoster.text,
                                                                  maxLines: maxLines,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: MainFonts.postMainText(size: 16)),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    showMore = !showMore;
                                                                  });
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(top: 8.0),
                                                                  child: Text(showMore ? 'See less' : 'See more',
                                                                      style: MainFonts.lableText(
                                                                          color: AppColors.secondaryColor10,
                                                                          fontSize: 14,
                                                                          weight: FontWeight.bold)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        replyOfPoster.mediaUrl == 'null' || replyOfPoster.mediaUrl.isEmpty ? SizedBox(height: 0) : Column(
                                                          children: [
                                                            const SizedBox(height: 16),
                                                            GestureDetector(
                                                              onTap: () {
                                                                FocusScope.of(context).unfocus();
                                                                Navigator.pushNamed(context, 'view_image', arguments: ImageViewArguments(replyOfPoster?.mediaUrl ?? '' , true));
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
                                                                        imageUrl: replyOfPoster.mediaUrl,
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
                                                            Container(
                                                              child: Image.asset('assets/icons/reply.png',
                                                                  color: AppColors.primaryColor30,
                                                                  height: 19,
                                                                  width: 19),
                                                            ),
                                                            const SizedBox(width: 5),
                                                            Text('Reply', style: MainFonts.postMainText(size: 13)),
                                                            const SizedBox(width: 40),
                                                            GestureDetector(
                                                              onTap: () {
                                                                ReviewRepo reviewRepo = ReviewRepo();
                                                                reviewRepo.likeReview(replyOfPoster?.postId ?? '', (replyOfPoster?.likedBy ?? []).contains(MyApp.userId));
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child: replyOfPoster.likedBy.contains(MyApp.userId) ? Image.asset('assets/icons/like-fill.png',
                                                                        color: AppColors.heartColor,
                                                                        height: 19,
                                                                        width: 19) : Image.asset('assets/icons/like.png',
                                                                        color: AppColors.primaryColor30,
                                                                        height: 19,
                                                                        width: 19),
                                                                  ),
                                                                  const SizedBox(width: 5),
                                                                  Text(replyOfPoster.likedBy.length.toString(),
                                                                      style: MainFonts.postMainText(size: 12)),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              color: Colors.transparent,
                                              padding: EdgeInsets.only(left: 10, right: 10, bottom: 16),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 38,
                                                    color: AppColors.transparentComponentColor,
                                                  ),
                                                  Text('Show ${commentCount} more replies', style: MainFonts.postMainText(size: 16, color: AppColors.secondaryColor10)),
                                                ],
                                              ),
                                            ),
                                            Line(),
                                          ],
                                        ),
                                      ],
                                    )
                                        : PostModel(
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
                                    ),
                                  );
                                }) : Container(
                                margin: EdgeInsets.only(top: 40, bottom: 20), child: Center(child: Text('No Replies', style: MainFonts.filterText(color: AppColors.lightTextColor)))),
                          ],
                        ),
                      );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
              Container(
                padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.lightTextColor,
                      width: 0.3,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    TextField(
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 12,
                      maxLength: AppValues.maxCharactersPost,
                      style: MainFonts.searchText(color: AppColors.primaryColor30),
                      focusNode: _focusPostTextNode,
                      controller: postTextController,
                      onChanged: (value) {
                        _onTextChanged();
                        if (currentCharacters > AppValues.maxCharactersPost) {
                          mySnackBarShow(context, 'Character limit exceeded!');
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 20, left: 20,
                            top: 10, bottom: 10),
                        fillColor: AppColors.transparentComponentColor.withOpacity(0.1/2),
                        filled: true,
                        hintText: 'Add a reply...',
                        hintStyle: MainFonts.searchText(color: AppColors.transparentComponentColor),
                        suffix: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, 'upload', arguments: TwoStringArg(widget.postId, postTextController.text));
                            },
                            child: Icon(Icons.open_in_full_rounded, color: AppColors.transparentComponentColor,)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              30),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    !_hasPostTextFocus ? SizedBox() : Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0).copyWith(
                          //     left: 15,
                          //     right: 15,
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       GestureDetector(
                          //         onTap: () {
                          //           pickImage(ImageSource.gallery);
                          //         },
                          //         child: SvgPicture.asset('assets/svg/gallery.svg', color: AppColors.textColor),
                          //       ),
                          //       SizedBox(width: 14),
                          //       GestureDetector(
                          //         onTap: () {
                          //           pickImage(ImageSource.camera);
                          //         },
                          //         child: Icon(Icons.camera_alt_outlined, color: AppColors.textColor),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(4),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      backgroundColor: AppColors.transparentComponentColor,
                                      value: progress,
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(currentCharacters < AppValues.maxCharactersPost ? AppColors.textColor : AppColors.errorColor),
                                    ),
                                    Text(
                                      '${currentCharacters <= AppValues.maxCharactersPost ? currentCharacters : AppValues.maxCharactersPost}',
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textColor
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15)
                            ],
                          ),
                          BlocConsumer<UploadReviewBloc, UploadReviewState>(
                              listener: (context, state) {
                                if (state is UploadReviewSuccess) {
                                  FocusScope.of(context).unfocus();
                                  
                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    mySnackBarShow(context, 'Your Post sent.');
                                  });
                                } else if(state is UploadReviewFaild) {
                                  mySnackBarShow(context, 'Something went wrong.');
                                }
                              },
                              builder: (context, state) {
                                if (state is UploadReviewLoading) {
                                  return Container(
                                    height: 35,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.secondaryColor10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                          elevation: AppElevations.buttonElev,
                                        ),
                                        onPressed: () {
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 5, right: 5),
                                          child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Center(
                                                  child: CircularProgressIndicator(
                                                      strokeWidth:
                                                      2,
                                                      color:
                                                      AppColors.primaryColor30))),
                                        )),
                                  );
                                }
                                return Container(
                                  height: 35,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: (postTextController.text.trim().length > 1) || _selectedMedia != null ? AppColors.secondaryColor10 : AppColors.transparentComponentColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20)),
                                        elevation: AppElevations.buttonElev,
                                      ),
                                      onPressed: () async {

                                        if ((postTextController.text.trim().length > 1) || _selectedMedia != null) {
                                          // Post Confession
                                          BlocProvider.of<UploadReviewBloc>(context)
                                              .add(UploadClickEvent(mediaSelected: null, postText: postTextController.text.trim(), parentId: widget.postId,
                                          ));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                        child: Text('Post',
                                            style: MainFonts.uploadButtonText(size: 16)),
                                      )),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}