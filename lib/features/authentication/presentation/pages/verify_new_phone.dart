
import 'package:flutter/material.dart';
import 'package:review_app/features/authentication/presentation/pages/update_password.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../../reviews/presentation/widgets/shadow.dart';
import '../../data/repositories/users_repo.dart';
import '../bloc/signup_bloc/signup_bloc.dart';
import 'forgot_password.dart';

class VerifyNewPhoneNo extends StatefulWidget {

  final String phoneNo;
  final String verifyForWhat;

  const VerifyNewPhoneNo({super.key,
    required this.phoneNo, required this.verifyForWhat,
  });

  @override
  State<VerifyNewPhoneNo> createState() => _VerifyNewPhoneNoState();
}

class _VerifyNewPhoneNoState extends State<VerifyNewPhoneNo> {

  final FocusNode _focusCodeNode = FocusNode();
  bool _hasCodeFocus = false;

  TextEditingController codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if(!isNumeric(input) || input.length != 6){
          return 'Invalid Code';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _focusCodeNode.addListener(() {
      setState(() {
        _hasCodeFocus = _focusCodeNode.hasFocus;
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
                    Text('Verify Phone no', style: MainFonts.pageTitleText()),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
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
                        child: Text('Verification Code', style: MainFonts.lableText()),
                      ),
                      Container(
                        child: TextFormField(
                          maxLength: 6,
                          controller: codeController,
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 0);
                          }),
                          style: MainFonts.textFieldText(),
                          focusNode: _focusCodeNode,
                          cursorHeight: TextCursorHeight.cursorHeight,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 20, right: 20),
                            fillColor: AppColors.primaryColor30,
                            filled: true,
                            hintText:
                            _hasCodeFocus ? 'XXXXXX' : null,
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
                      Text('Verification code has been sent to ${widget.phoneNo}, verify phone number to ${widget.verifyForWhat == "phoneno" ? 'change phone no' : widget.verifyForWhat == "password" ? 'change password' : 'login and change password'}.', style: AuthFonts.authMsgText(color: Colors.grey)),
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
                            onPressed: () async {
                              bool isValid = _formKey.currentState!.validate();
                              // if(isValid){
                              //   SignupBloc signupBlocObj = SignupBloc();
                              //   bool isOtpVerified = await signupBlocObj.optVerify(codeController.text.trim());
                              //
                              //   if(isOtpVerified){
                              //
                              //     UsersRepo userRepoObj = UsersRepo();
                              //     int status =
                              //     widget.verifyForWhat == "phoneno" ? await userRepoObj.changePhoneNo(widget.phoneNo) : widget.verifyForWhat == "password" ? await userRepoObj.changePassword(UpdatePassword.newPassword) : 4;
                              //     if (status == 1) {
                              //       FocusScope.of(context).unfocus();
                              //       mySnackBarShow(
                              //           context, '${widget.verifyForWhat == "phoneno" ? "Phone No" : "Password"} Changed.');
                              //       Future.delayed(
                              //           const Duration(milliseconds: 300), () {
                              //         Navigator.of(context).pop();
                              //         Navigator.of(context).pop();
                              //       });
                              //     } else if(status == 4) {
                              //       // Login
                              //       try{
                              //         updateLoginStatus(true);
                              //         loginDetails(ForgotPassword.userId.toString(), ForgotPassword.dbUsername.toString(), ForgotPassword.phoneNo.toString());
                              //
                              //         FocusScope.of(context).unfocus();
                              //         Future.delayed(
                              //             const Duration(milliseconds: 300), () {
                              //
                              //           Navigator.popUntil(
                              //               context, (route) => route.isFirst);
                              //           Navigator.of(context)
                              //               .pushReplacementNamed('landing');
                              //         });
                              //       } catch(e){
                              //         mySnackBarShow(context,
                              //             'Something went wrong! Try again.');
                              //       }
                              //     } else if (status == -1) {
                              //       logOut();
                              //     } else {
                              //       mySnackBarShow(context,
                              //           'Something went wrong! Try again.');
                              //     }
                              //   } else{
                              //     mySnackBarShow(context, 'Invalid verification code.');
                              //   }
                              // }
                            },
                            child: Text('Verify Code', style: AuthFonts.authButtonText())
                        ),
                      )
                    ]),
              )),
        ));
  }

  logOut() {
    clearSharedPrefs();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed('login');
  }
}