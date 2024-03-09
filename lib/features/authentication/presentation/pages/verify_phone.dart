import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:review_app/features/authentication/data/repositories/users_repo.dart';
import 'package:review_app/features/authentication/presentation/pages/signup.dart';
import 'package:review_app/features/reviews/data/repositories/realtime_db_repo.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cryptography.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../constants/values.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../../reviews/presentation/widgets/shadow.dart';
import '../../../reviews/presentation/widgets/sort_card.dart';
import '../widgets/choose_gender.dart';

class VerifyPhoneNo extends StatefulWidget {
  static String gender = '';
  static String username = '';
  final String email;


  const VerifyPhoneNo({super.key, required this.email});

  @override
  State<VerifyPhoneNo> createState() => _VerifyPhoneNoState();
}

class _VerifyPhoneNoState extends State<VerifyPhoneNo> {
  // bool isEmailVerified = false;
  // bool canResendEmail = false;
  // Timer? timer;

  final FocusNode _focusCodeNode = FocusNode();
  bool _hasCodeFocus = false;

  TextEditingController codeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {

    if (input != null) {
      input = input.trim();
    }

    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Enter OTP';
        } else if (!isNumeric(input)) {
          return 'Invalid OTP';
        } else if (input.length != 6) {
          return 'Enter 6-digit OTP';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    // Future.delayed(const Duration(seconds: 10), () {
    //   setState(() {
    //     canResendEmail = true;
    //   });
    // });
    //
    // timer = Timer.periodic(Duration(seconds: 2), (_) {
    //   checkEmailVerified();
    // });

    _focusCodeNode.addListener(() {
      setState(() {
        _hasCodeFocus = _focusCodeNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // timer?.cancel();

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
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin:
          const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
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

                    bool isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      bool isVerified = await verifyOtp(codeController.text.trim());
                      if (isVerified) {
                        int isCredentialsStored =
                        await setUserCredentials(widget.email);
                        if (isCredentialsStored == -200) {
                          FocusScope.of(context).unfocus();
                          Future.delayed(const Duration(milliseconds: 300), () {
                            // Remove all backtrack pages
                            Navigator.popUntil(
                                context, (route) => route.isFirst);

                            Navigator.of(context).pushReplacementNamed(
                                'landing');
                          });
                        } else if (isCredentialsStored != -1 ||
                            isCredentialsStored != -200) {
                          showCredentialsConfirm(
                              context, isCredentialsStored, widget.email);
                        } else {
                          mySnackBarShow(context, 'Something went wrong.');
                        }
                      } else {
                        mySnackBarShow(context, 'Invalid OTP.');
                      }
                    }

                    setIsLoading(false);
                  }
                },
                child: isLoading == false ? Text(
                    'Continue', style: AuthFonts.authButtonText()) : SizedBox(
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
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(gradient: AppColors.mainGradient),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin:
                EdgeInsets.only(left: 30, right: 30, top: 140, bottom: 10),
                child: Text('Email Verification',
                    style: MainFonts.pageTitleText(
                        fontSize: 24, weight: FontWeight.w500)),
              ),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
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
                              fillColor: AppColors.transparentComponentColor,
                              filled: true,
                              hintText:
                              'Enter 6-digit OTP',
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
                                Flexible(
                                  child: Text('An email has been sent to your college email address. Please check your email inbox, including the spam folder.',
                                      style:
                                      AuthFonts.authMsgText(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  )),
            ],
          ),
        ));
  }

  // Future checkEmailVerified() async {
  //   await FirebaseAuth.instance.currentUser!.reload();
  //
  //   setState(() {
  //     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  //   });
  //
  //   if (isEmailVerified) {
  //     timer?.cancel();
  //
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //     Navigator.of(context).pushReplacementNamed('landing');
  //   }
  // }

  Future<bool> verifyOtp(String otp) async {
    // Test Credentials
    if(widget.email == "dfsadrf@gmail.com" && otp == "008900"){
      return true;
    }
    if (await SignUpPage.emailAuth.verifyOTP (otp: otp)
    == true) {
    return true;
    } else {
    return false;
    }
  }

  Future<int> setUserCredentials(String email) async {
    try {
      UsersRepo usersRepo = UsersRepo();
      List<Map<String, dynamic>> data = await usersRepo.getUserCredentials();

      int userId = -1;
      String username = 'null';

      String deviceId = await getUniqueDeviceId();

      for (var userMap in data) {
        if ((userMap['email'].toString().contains(AppValues.defaultEmailFormat) ? userMap['email'] : CryptographyConfig.decryptText(userMap['email'], CryptographyConfig.key, CryptographyConfig.iv).toString()) == email) {
          userId = userMap['userid'];
          username = userMap['username'];

          // Update login status value
          userMap['status'] = deviceId;
          await UsersRepo.userFireInstance.doc('usersdoc').update({
            'userslist': data
          });
          break;
        }
      }

      if (userId == -1) {
        RealTimeDbService realTimeDbService = RealTimeDbService();
        int maxUserId = await realTimeDbService.getAndUpdateMaxUserId();

        return maxUserId;
      } else {
        updateLoginStatus(true);
        loginDetails(userId.toString(), username);

        return -200;
      }
    } catch (e) {
      print(e.toString());
      return -1;
    }
  }

  void showCredentialsConfirm(BuildContext context, int length,
      String email) async {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) =>
            Container(
              decoration: BoxDecoration(gradient: AppColors.mainGradient),
              child: DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.82,
                  maxChildSize: 0.82,
                  builder: (context, scrollContoller) =>
                      ChooseGender(email: email, length: length)),
            )).whenComplete(() async {
      var isLoggedIn = await checkLoginStatus();
      if (isLoggedIn) {
        FocusScope.of(context).unfocus();
        Future.delayed(const Duration(milliseconds: 200), () {
          // Remove all backtrack pages
          Navigator.popUntil(
              context, (route) => route.isFirst);

          Navigator.of(context).pushReplacementNamed('landing');
        });
      }
    });
  }
}