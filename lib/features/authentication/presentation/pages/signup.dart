import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/elevation.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../../reviews/presentation/widgets/shadow.dart';
import '../bloc/signup_bloc/signup_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  static String verify = "";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _focusNameNode = FocusNode();
  bool _hasNameFocus = false;

  final FocusNode _focusUsernameNode = FocusNode();
  bool _hasUsernameFocus = false;

  final FocusNode _focusPhoneNoNode = FocusNode();
  bool _hasPhoneNoFocus = false;

  final FocusNode _focusPasswordNode = FocusNode();
  bool _hasPasswordFocus = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String countryCode = "+91";

  String? _validateInput(String? input, int index) {
    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 2) {
          return 'Name is too short';
        } else if (input.length > 40) {
          return 'Name is too long';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 2) {
          return 'Username is too short';
        } else if (input.length > 30) {
          return 'Username is too long';
        }
        break;

      case 2:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (!isNumeric(input) || input.length != 10) {
          return 'Invalid phone number';
        }
        break;

      case 3:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 6) {
          return 'Password is too short';
        } else if (input.length > 30) {
          return 'Password is too long';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNameNode.addListener(() {
      setState(() {
        _hasNameFocus = _focusNameNode.hasFocus;
      });
    });

    _focusUsernameNode.addListener(() {
      setState(() {
        _hasUsernameFocus = _focusUsernameNode.hasFocus;
      });
    });

    _focusPhoneNoNode.addListener(() {
      setState(() {
        _hasPhoneNoFocus = _focusPhoneNoNode.hasFocus;
      });
    });

    _focusPasswordNode.addListener(() {
      setState(() {
        _hasPasswordFocus = _focusPasswordNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
                  child: Text('Sign Up', style: MainFonts.pageBigTitleText()),
                ),
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                              child: Text('Full Name',
                                  style: MainFonts.lableText()),
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
                                  hintText: _hasNameFocus ? 'Enter name' : null,
                                  hintStyle: MainFonts.hintFieldText(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width: AppBoarderWidth.searchBarWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                              child: Text('Username',
                                  style: MainFonts.lableText()),
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
                                  hintText: _hasUsernameFocus
                                      ? 'Enter username'
                                      : null,
                                  hintStyle: MainFonts.hintFieldText(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width: AppBoarderWidth.searchBarWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                              child: Text('Phone Number',
                                  style: MainFonts.lableText()),
                            ),
                            Container(
                              child: TextFormField(
                                maxLength: 10,
                                controller: phoneNoController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: ((value) {
                                  return _validateInput(value, 2);
                                }),
                                style: MainFonts.textFieldText(),
                                keyboardType: TextInputType.number,
                                focusNode: _focusPhoneNoNode,
                                cursorHeight: TextCursorHeight.cursorHeight,
                                decoration: InputDecoration(
                                  prefixIcon: CountryCodePicker(
                                    textStyle: MainFonts.textFieldText(),
                                    onChanged: ((value) {
                                      countryCode = value.dialCode.toString();
                                    }),
                                    initialSelection: '+91',
                                    favorite: ['+91', 'IND'],
                                    showFlagDialog: true,
                                    showFlagMain: false,
                                    alignLeft: false,
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      top: 16, bottom: 16, left: 20, right: 20),
                                  fillColor: AppColors.primaryColor30,
                                  filled: true,
                                  hintText: _hasPhoneNoFocus
                                      ? 'Enter phone number'
                                      : null,
                                  hintStyle: MainFonts.hintFieldText(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width: AppBoarderWidth.searchBarWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                              child: Text('Password',
                                  style: MainFonts.lableText()),
                            ),
                            Container(
                              child: TextFormField(
                                controller: passwordController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: ((value) {
                                  return _validateInput(value, 3);
                                }),
                                style: MainFonts.textFieldText(),
                                focusNode: _focusPasswordNode,
                                cursorHeight: TextCursorHeight.cursorHeight,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 16, bottom: 16, left: 20, right: 20),
                                  fillColor: AppColors.primaryColor30,
                                  filled: true,
                                  hintText: _hasPasswordFocus
                                      ? 'Enter password'
                                      : null,
                                  hintStyle: MainFonts.hintFieldText(),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width:
                                              AppBoarderWidth.reviewUploadWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.reviewUploadRadius),
                                      borderSide: BorderSide(
                                          width: AppBoarderWidth.searchBarWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  Text('Already has account, ',
                                      style: AuthFonts.authMsgText()),
                                  Text('Login',
                                      style: AuthFonts.authMsgText(
                                          color: AppColors.secondaryColor10)),
                                  Text(' now.', style: AuthFonts.authMsgText()),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            BlocConsumer<SignupBloc, SignupState>(
                              listener: (context, state) {
                                if (state is SignUpInvalidUsernameState) {
                                  mySnackBarShow(context, 'This username is already in use! Try Another.');
                                } else if (state is SignupOtpSentState) {
                                  FocusScope.of(context).unfocus();
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {

                                  Navigator.of(context).pushNamed('verifyphone',
                                    arguments: state.phoneNo,);
                                  });             
                                  
                                } else if (state is SignupOtpSentFailedState || state is SignupFailedState) {
                                  mySnackBarShow(context, 'Something went wrong! Try again.');
                                }
                              },
                              builder: (context, state) {
                                if (state is SignupLoadingState) {
                                  return Container(
                                    height: 55,
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
                                        onPressed: () {},
                                        child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: AppValues
                                                            .progresBarWidth,
                                                        color: AppColors
                                                            .primaryColor30)))),
                                  );
                                }
                                return Container(
                                  height: 55,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColors.secondaryColor10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppBoarderRadius.buttonRadius)),
                                        elevation: AppElevations.buttonElev,
                                      ),
                                      onPressed: () {
                                        bool isValid =
                                            _formKey.currentState!.validate();
                                        if (isValid) {
                                          BlocProvider.of<SignupBloc>(context)
                                              .add(SignupClickEvent(
                                                  phoneNo: countryCode +
                                                      phoneNoController.text
                                                          .toString(), username: usernameController.text));
                                        }
                                      },
                                      child: Text('Sign Up',
                                          style: AuthFonts.authButtonText())),
                                );
                              },
                            ),
                          ]),
                    )),
              ],
            ),
          ),
        ));
  }
}
