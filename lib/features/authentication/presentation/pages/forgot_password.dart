import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/helpers.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:review_app/features/authentication/data/repositories/users_repo.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../constants/values.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../../reviews/domain/entities/verify_phoneno_argument.dart';
import '../../../reviews/presentation/widgets/shadow.dart';
import '../../../reviews/presentation/widgets/snackbar.dart';
import '../bloc/signup_bloc/signup_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static String dbUsername = '';
  static int userId = -1;
  static String phoneNo = '';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final FocusNode _focusUsernameNode = FocusNode();
  bool _hasUsernameFocus = false;

  TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 2) {
          return 'Username is too short';
        } else if (input.length > 30) {
          return 'Username is too long';
        } else if (!doesNotContainSpaces(input)) {
          return 'Username should not contain any spaces';
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
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoading = false;

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
                    Text('Forgot Password', style: MainFonts.pageTitleText()),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                boxShadow: ContainerShadow.boxShadow,
                color: AppColors.primaryColor30,
                borderRadius:
                    BorderRadius.circular(AppBoarderRadius.reviewUploadRadius),
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
                        child:
                            Text('Your username', style: MainFonts.lableText()),
                      ),
                      Container(
                        child: TextFormField(
                          controller: usernameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      SizedBox(height: 40),
                      Container(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppBoarderRadius.buttonRadius)),
                              elevation: AppElevations.buttonElev,
                            ),
                            onPressed: () async {
                              if (!isLoading) {
                                setIsLoading(true);

                                bool isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  try {
                                    UsersRepo userRepoObj = UsersRepo();
                                    List<Map<String, dynamic>> data =
                                        await userRepoObj.getUserCredentials();

                                    bool hasUsernameAlready = false;

                                    for (var userMap in data) {
                                      if (userMap['username']
                                              .toString()
                                              .toLowerCase() ==
                                          usernameController.text
                                              .toLowerCase()) {
                                        hasUsernameAlready = true;
                                        ForgotPassword.dbUsername =
                                            userMap['username'];
                                        ForgotPassword.userId = userMap['uid'];
                                        ForgotPassword.phoneNo =
                                            userMap['phoneno'];
                                        break;
                                      }
                                    }

                                    if (!hasUsernameAlready) {
                                      mySnackBarShow(context,
                                          'Account not found with this username.');
                                    } else {
                                      SignupBloc signupBlocObj = SignupBloc();
                                      bool isOtpSent = await signupBlocObj
                                          .sendEmailVerificationLink(
                                              ForgotPassword.phoneNo);

                                      if (isOtpSent) {
                                        FocusScope.of(context).unfocus();
                                        Future.delayed(
                                            const Duration(milliseconds: 300),
                                            () {
                                          Navigator.of(context).pushNamed(
                                              'verifynewphone',
                                              arguments: VerifyPhoneNoArg(
                                                  ForgotPassword.phoneNo,
                                                  "forgotpassword"));
                                        });
                                      } else {
                                        mySnackBarShow(context,
                                            'Something went wrong! Try again.');
                                      }
                                    }
                                  } catch (e) {
                                    mySnackBarShow(context,
                                        'Something went wrong! Try again.');
                                  }
                                }

                                setIsLoading(false);
                              }
                            },
                            child: isLoading == false
                                ? Text('Next',
                                style: AuthFonts.authButtonText())
                                : SizedBox(
                                width: 30,
                                height: 30,
                                child: Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth:
                                        AppValues.progresBarWidth,
                                        color:
                                        AppColors.primaryColor30))),
                        ),
                      ),
                    ]),
              )),
        ));
  }

  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }
}
