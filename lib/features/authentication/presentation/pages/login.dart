import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/elevation.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/utils/methods.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/values.dart';
import '../../../../utils/fonts.dart';
import '../../../reviews/presentation/widgets/shadow.dart';
import '../bloc/login_bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _focusUsernameNode = FocusNode();
  bool _hasUsernameFocus = false;

  final FocusNode _focusPasswordNode = FocusNode();
  bool _hasPasswordFocus = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    if(input != null){
      input = input.trim();
    }
    
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

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _focusUsernameNode.addListener(() {
      setState(() {
        _hasUsernameFocus = _focusUsernameNode.hasFocus;
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
                      EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
                  child: Text('Login', style: MainFonts.pageBigTitleText()),
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
                              child: Text('Username',
                                  style: MainFonts.lableText()),
                            ),
                            Container(
                              child: TextFormField(
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
                            SizedBox(height: 40),
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
                                  return _validateInput(value, 1);
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
                                Navigator.pushNamed(context, 'signup');
                              },
                              child: Row(
                                children: [
                                  Text('Haven\'t created account, ',
                                      style: AuthFonts.authMsgText()),
                                  Text('Sign Up',
                                      style: AuthFonts.authMsgText(
                                          color: AppColors.secondaryColor10)),
                                  Text(' now', style: AuthFonts.authMsgText()),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            BlocConsumer<LoginBloc, LoginState>(
                              listener: (context, state) {
                                if (state is LoginInvalidUsernameState) {
                                  mySnackBarShow(context,
                                      'Account not found with this username.');
                                } else if (state is LoginSucessState) {
                                  FocusScope.of(context).unfocus();
                                  usernameController.text = '_';
                                  passwordController.text = '_';
                                  Future.delayed(
                                      const Duration(milliseconds: 300), () {

                                     Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                      Navigator.of(context)
                                          .pushReplacementNamed('landing');
                                  });                                 
                                } else if (state is LoginInvalidPasswordState) {
                                  mySnackBarShow(
                                      context, 'Incorrect Password.');
                                } else if (state is LoginFailedState) {
                                  mySnackBarShow(
                                      context, 'Something went wrong.');
                                }
                              },
                              builder: (context, state) {
                                if (state is LoginLoadingState) {
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
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(LoginClickEvent(
                                                  username:
                                                      usernameController.text.trim(),
                                                  password:
                                                      passwordController.text.trim()));
                                        }
                                      },
                                      child: Text('Login',
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
