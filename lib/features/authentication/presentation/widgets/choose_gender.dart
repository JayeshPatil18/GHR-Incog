import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/features/authentication/presentation/pages/verify_phone.dart';
import 'package:review_app/utils/fonts.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../constants/values.dart';
import '../../../../utils/methods.dart';
import '../../../reviews/presentation/widgets/snackbar.dart';
import '../../data/repositories/users_repo.dart';

class ChooseGender extends StatefulWidget {
  final String email;
  final int length;

  const ChooseGender({super.key, required this.email, required this.length});

  @override
  State<StatefulWidget> createState() {
    return ChooseGenderState();
  }
}

class ChooseGenderState extends State<ChooseGender> {
  void updateSelectedValue(String value) {
    setState(() {
      VerifyPhoneNo.gender = value;
    });
  }

  final FocusNode _focusUsernameNode = FocusNode();
  bool _hasUsernameFocus = false;
  TextEditingController usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _validateInput(String? input, int index) {
    if (input != null) {
      input = input.trim();
    }

    switch (index) {
      case 0:
      // Write logic to check email from this college.
        if (input == null || input.isEmpty) {
          return 'Enter username';
        }
        break;

      default:
        return null;
    }
  }

  void setInitialDetails() {
    VerifyPhoneNo.username = 'user${widget.length}';
    usernameController.text = VerifyPhoneNo.username;

    // Find gender of user using email address
  }

  @override
  void initState() {
    super.initState();

    setInitialDetails();

    _focusUsernameNode.addListener(() {
      setState(() {
        _hasUsernameFocus = _focusUsernameNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;

  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5),
              child: Text('Username', style: MainFonts.lableText()),
            ),
            Container(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: usernameController,
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 0);
                          }),
                          style: MainFonts.textFieldText(),
                          focusNode: _focusUsernameNode,
                          cursorHeight: TextCursorHeight.cursorHeight,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 20, right: 20),
                            fillColor: AppColors.transparentComponentColor,
                            filled: true,
                            hintText: 'Enter username',
                            hintStyle: MainFonts.hintFieldText(),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 4, right: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.verified_user,
                                  color: AppColors.lightTextColor, size: 12),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                    'Username should not reveal your identity.',
                                    style:
                                    AuthFonts.authMsgText(fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                      ]),
                )),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 5),
              child: Text('Gender', style: MainFonts.lableText()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.update_disabled_rounded,
                      color: AppColors.lightTextColor, size: 12),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                        'You can not change later.',
                        style:
                        AuthFonts.authMsgText(fontSize: 12)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppColors.textColor
                        ),
                        child: Radio(
                          value: 'Male',
                          groupValue: VerifyPhoneNo.gender,
                          onChanged: (value) {
                            updateSelectedValue(value!);
                          },
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            updateSelectedValue('Male');
                          },
                          child: Text("Male", style: MainFonts.filterText(color: AppColors.textColor))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppColors.textColor
                        ),
                        child: Radio(
                          value: 'Female',
                          groupValue: VerifyPhoneNo.gender,
                          onChanged: (value) {
                            updateSelectedValue(value!);
                          },
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            updateSelectedValue('Female');
                          },
                          child: Text("Female", style: MainFonts.filterText(color: AppColors.textColor))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Theme(
                        data: ThemeData(
                            unselectedWidgetColor: AppColors.textColor
                        ),
                        child: Radio(
                          value: 'Other',
                          groupValue: VerifyPhoneNo.gender,
                          onChanged: (value) {
                            updateSelectedValue(value!);
                          },
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            updateSelectedValue('Other');
                          },
                          child: Text('Other', style: MainFonts.filterText(color: AppColors.textColor))),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.secondaryColor10,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            AppBoarderRadius
                                .buttonRadius)),
                    elevation: AppElevations.buttonElev,
                  ),
                  onPressed: () async {
                    if(!isLoading){
                      setIsLoading(true);

                      bool isValid = _formKey.currentState!.validate();
                      if(isValid){
                        VerifyPhoneNo.username = usernameController.text.trim();

                        try{
                          UsersRepo usersRepo = UsersRepo();

                          int validUsername = await usersRepo.validUsernameCheck(VerifyPhoneNo.username);

                          if (validUsername == 1) {
                            // Username is Unique

                            int userId = await usersRepo.addUser(widget.length, widget.email, VerifyPhoneNo.gender,
                                VerifyPhoneNo.username);

                            updateLoginStatus(true);
                            loginDetails(userId.toString(), VerifyPhoneNo.username);

                            Timer(Duration(milliseconds: AppValues.closeDelay), () {
                              Navigator.pop(context);
                            });

                          } else if (validUsername == -1) {
                            // Username already exists
                            mySnackBarShow(context, 'Username already exist. Try another!');
                          } else if (validUsername == 0) {
                            // Exception
                            mySnackBarShow(context, 'Something went wrong.');
                          }
                        } catch(e){
                          mySnackBarShow(context, 'Something went wrong.');
                        }
                      }

                      setIsLoading(false);
                    }
                  },
                  child: isLoading == false ? Text('Confirm',
                      style: AuthFonts.authButtonText()) : SizedBox(
                      width: 30,
                      height: 30,
                      child: Center(
                          child: CircularProgressIndicator(
                              strokeWidth:
                              AppValues.progresBarWidth,
                              color:
                              AppColors.primaryColor30)))),
            ),
          ],
        ),
      ),
    );
  }
}