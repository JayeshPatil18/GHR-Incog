import 'dart:io';

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
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../../domain/entities/image_argument.dart';
import '../bloc/upload_review/upload_review_bloc.dart';
import '../bloc/upload_review/upload_review_event.dart';
import '../widgets/dropdown.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class UploadReview extends StatefulWidget {
  final String parentId;
  const UploadReview({super.key, required this.parentId});

  @override
  State<UploadReview> createState() => _UploadReviewState();
}

class _UploadReviewState extends State<UploadReview> {
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
                          Text('Review', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
                        ],
                      ),
                      BlocConsumer<UploadReviewBloc, UploadReviewState>(
                          listener: (context, state) {
                            if (state is UploadReviewSuccess) {
                              FocusScope.of(context).unfocus();
                              mySnackBarShow(context, 'Your Post sent.');
                              Future.delayed(const Duration(milliseconds: 300), () {
                                Navigator.of(context).pop();
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

                                    bool isValid =
                                        _formKey.currentState!.validate();
                                    if (isValid && (postTextController.text.trim().length > 1) || _selectedMedia != null) {
                                      // Post Confession
                                      FocusScope.of(context).unfocus();
                                      BlocProvider.of<UploadReviewBloc>(context)
                                          .add(UploadClickEvent(mediaSelected: _selectedMedia, postText: postTextController.text.trim(), parentId: widget.parentId,
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100, left: 10, right: 10),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage('https://i.insider.com/61e9ac1cda4bc600181aaf63?width=700'),
                                    radius: 22,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      maxLines: null,
                                      maxLength: AppValues.maxCharactersPost,
                                      controller: postTextController,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: ((value) {
                                        return _validateInput(value, 0);
                                      }),
                                      style: MainFonts.postMainText(size: 18),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        hintText: "Write fearlessly...",
                                        hintStyle: MainFonts.hintFieldText(size: 18, color: AppColors.transparentComponentColor),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        _onTextChanged();
                                        if (currentCharacters > AppValues.maxCharactersPost) {
                                          mySnackBarShow(context, 'Character limit exceeded!');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            _selectedMedia != null ? Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    Navigator.pushNamed(context, 'view_image', arguments: ImageViewArguments(_selectedMedia?.path ?? '' , false));
                            },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    height: 260,
                                    margin: EdgeInsets.only(left: 50),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(_selectedMedia!, fit: BoxFit.cover)),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment(1, -1),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedMedia = null;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightBlackColor,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                            child: Icon(Icons.close_rounded, color: AppColors.primaryColor30)),
                                      ),
                                    )
                                ),
                              ],
                            ) : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.lightTextColor,
                        width: 0.3,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(
                          left: 15,
                          right: 15,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                                child: SvgPicture.asset('assets/svg/gallery.svg', color: AppColors.textColor),
                            ),
                            SizedBox(width: 14),
                            GestureDetector(
                                onTap: () {
                                  pickImage(ImageSource.camera);
                                },
                                child: Icon(Icons.camera_alt_outlined, color: AppColors.textColor),
                            ),
                          ],
                        ),
                      ),
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