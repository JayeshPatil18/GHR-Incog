import 'package:flutter/material.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../utils/fonts.dart';
import '../widgets/shadow.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  final FocusNode _focusNameNode = FocusNode();
  bool _hasNameFocus = false;

  final FocusNode _focusUsernameNode = FocusNode();
  bool _hasUsernameFocus = false;

  final FocusNode _focusBioNode = FocusNode();
  bool _hasBioFocus = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 2:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      default:
        return null;
    }
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
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                          color: AppColors.textColor, size: 26),
                    ),
                    SizedBox(width: 10),
                    Text('Edit Profile', style: MainFonts.pageTitleText()),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    boxShadow: ContainerShadow.boxShadow,
                    color: AppColors.primaryColor30,
                    borderRadius: BorderRadius.circular(
                        AppBoarderRadius.reviewUploadRadius),
                  ),
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, left: 5),
                            child: Text('Full Name', style: MainFonts.lableText()),
                          ),
                          Container(
                            child: TextFormField(
                              controller: nameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 0);
                              }),
                              style: MainFonts.textFieldText(),
                              focusNode: _focusNameNode,
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText:
                                    _hasNameFocus ? 'Enter name' : null,
                                hintStyle: MainFonts.hintFieldText(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.searchBarWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.searchBarWidth,
                                        color: AppBoarderColor.errorColor)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, left: 5),
                            child: Text('Username', style: MainFonts.lableText()),
                          ),
                          Container(
                            child: TextFormField(
                              controller: usernameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 1);
                              }),
                              style: MainFonts.textFieldText(),
                              focusNode: _focusUsernameNode,
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText:
                                    _hasUsernameFocus ? 'Enter username' : null,
                                hintStyle: MainFonts.hintFieldText(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.searchBarWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.searchBarWidth,
                                        color: AppBoarderColor.errorColor)),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, left: 5),
                            child: Text('Bio', style: MainFonts.lableText()),
                          ),
                          Container(
                            child: TextFormField(
                              maxLines: 3,
                              controller: bioController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 2);
                              }),
                              style: MainFonts.textFieldText(),
                              focusNode: _focusBioNode,
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText:
                                    _hasBioFocus ? 'Enter bio' : null,
                                hintStyle: MainFonts.hintFieldText(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.searchBarWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width: AppBoarderWidth.searchBarWidth,
                                        color: AppBoarderColor.errorColor)),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppBoarderRadius.buttonRadius)),
                                    elevation: AppElevations.buttonElev,
                                    ),
                                onPressed: () { 
                                  _formKey.currentState!.validate();
                                 },
                                child: Text('Login', style: AuthFonts.authButtonText())
                              ),
                          ),
                        ]),
                  )),
            ],
          ),
        ));
  }
}