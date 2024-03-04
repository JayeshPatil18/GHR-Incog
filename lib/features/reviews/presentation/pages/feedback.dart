import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:image_picker/image_picker.dart';
import 'package:review_app/features/reviews/presentation/widgets/choose_profile_icon.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../constants/values.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../../authentication/data/repositories/users_repo.dart';
import '../../data/repositories/realtime_db_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/shadow.dart';
import '../widgets/snackbar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {

  final FocusNode _focusFeedbackNode = FocusNode();
  bool _hasFeedbackFocus = false;

  TextEditingController feedbackController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    switch (index) {

      case 0:
        if (input == null || input.isEmpty) {
          return 'Write feedback';
        } else if (input.length < 2) {
          return 'Feedback is too short';
        } else if (input.length > AppValues.maxCharactersPost) {
          return 'Feedback is too long';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _focusFeedbackNode.addListener(() {
      setState(() {
        _hasFeedbackFocus = _focusFeedbackNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
                EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
                        Text('Feedback', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 40, bottom: 20, left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, left: 5),
                              child: Text('Write Feedback',
                                  style: MainFonts.lableText(fontSize: 16, color: AppColors.lightTextColor)),
                            ),
                            Container(
                              child: TextFormField(
                                maxLines: 8,
                                controller: feedbackController,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: ((value) {
                                  return _validateInput(value, 0);
                                }),
                                focusNode: _focusFeedbackNode,
                                style: MainFonts.textFieldText(),
                                cursorHeight: TextCursorHeight.cursorHeight,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 16, bottom: 16, left: 20, right: 20),
                                  fillColor: AppColors.transparentComponentColor.withOpacity(0.1),
                                  filled: true,
                                  hintText: 'Enhancements, Issues, Positives, Suggestions, etc.',
                                  hintStyle: MainFonts.hintFieldText(color: AppColors.transparentComponentColor, size: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.buttonRadius),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.buttonRadius),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 4, right: 4),
                              child: Text(
                                  'Your feedback will be kept anonymous.',
                                  style:
                                  AuthFonts.authMsgText(fontSize: 11, color: AppColors.transparentComponentColor)),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, top: 10, left: 20, right: 20),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor10,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(AppBoarderRadius.buttonRadius)),
                        elevation: AppElevations.buttonElev,
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (!isLoading) {
                          setIsLoading(true);

                          bool isValid =
                          _formKey.currentState!.validate();
                          if (isValid) {
                            List<String>? details =
                            await getLoginDetails();
                            int userId = int.parse(details?[0] ?? '');

                            final RealTimeDbService _realTimeDbService = RealTimeDbService();
                            int resultStatus = await _realTimeDbService.uploadFeedback(userId, feedbackController.text.trim());

                            if(resultStatus == 1){
                              FocusScope.of(context).unfocus();
                              mySnackBarShow(
                                  context, 'Feedback Submitted.');
                              Future.delayed(
                                  const Duration(milliseconds: 300),
                                      () {
                                    Navigator.of(context).pop();
                                  });
                            } else{
                              mySnackBarShow(context,
                                  'Something went wrong! Try again.');
                            }
                          }

                          setIsLoading(false);
                        }
                      },
                      child: isLoading == false ? Text('Submit', style: AuthFonts.authButtonText()) : SizedBox(
                          width: 30,
                          height: 30,
                          child: Center(
                              child: CircularProgressIndicator(
                                  strokeWidth:
                                  AppValues.progresBarWidth,
                                  color:
                                  AppColors.primaryColor30)))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  logOut() {
    clearSharedPrefs();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed('login');
  }

  void chooseProfileIconDialog(BuildContext context) {

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (context) => ChooseProfileIcon()).whenComplete(_onBottomSheetClosed);
  }

  void _onBottomSheetClosed() {
    setState(() {

    });
  }
}
