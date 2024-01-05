import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/helpers.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../constants/values.dart';
import '../../../../utils/fonts.dart';
import '../../../reviews/presentation/widgets/shadow.dart';
import '../bloc/signup_bloc/signup_bloc.dart';

class VerifyPhoneNo extends StatefulWidget {

  final String email;

  const VerifyPhoneNo({super.key, 
    required this.email
  });

  @override
  State<VerifyPhoneNo> createState() => _VerifyPhoneNoState();
}

class _VerifyPhoneNoState extends State<VerifyPhoneNo> {
  
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
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
          child: BlocConsumer<SignupBloc, SignupState>(
            listener: (context, state) {
              if (state is OtpCodeVerifiedState) {
                FocusScope.of(context).unfocus();
                Future.delayed(
                    const Duration(milliseconds: 300), () {

                  Navigator.popUntil(
                      context, (route) => route.isFirst);
                  Navigator.of(context)
                      .pushReplacementNamed('landing');
                });
              } else if(state is OtpCodeVerifiedFailedState){
                mySnackBarShow(context, 'Invalid verification code.');
              } else if(state is AddUserDataFailedState){
                mySnackBarShow(context, 'Something went wrong.');
                Navigator.pop(context);
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
                      bool isValid = _formKey.currentState!.validate();
                      if(isValid){
                        BlocProvider.of<SignupBloc>(context)
                            .add(VerifyClickEvent(otpCode: codeController.text.trim(), email: widget.email.trim()));
                      }
                    },
                    child: Text('Confirm',
                        style: AuthFonts.authButtonText())),
              );
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              gradient: AppColors.mainGradient),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin:
                EdgeInsets.only(left: 30, right: 30, top: 140, bottom: 10),
                child: Text('OTP Verification', style: MainFonts.pageTitleText(fontSize: 24, weight: FontWeight.w500)),
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
                              hintText: _hasCodeFocus
                                  ? 'XXXX'
                                  : null,
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
                            padding: const EdgeInsets.only(top: 10, left: 4, right: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.warning_amber_rounded, color: AppColors.lightTextColor, size: 12),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text('Also check spam mail emails.',
                                      style: AuthFonts.authMsgText(fontSize: 12)),
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
}