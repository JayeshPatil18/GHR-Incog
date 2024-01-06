import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  
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

    Future.delayed(
        const Duration(seconds: 10), () {
      setState(() {
        canResendEmail = true;
      });
    });

    timer = Timer.periodic(Duration(seconds: 2), (_) {
      checkEmailVerified();
    });

    _focusCodeNode.addListener(() {
      setState(() {
        _hasCodeFocus = _focusCodeNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text('Verification Email has been sent.', style: MainFonts.pageTitleText(fontSize: 24, weight: FontWeight.w500)),
              ),
            ],
          ),
        ));
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) {
      timer?.cancel();

      Navigator.popUntil(
          context, (route) => route.isFirst);
      Navigator.of(context)
          .pushReplacementNamed('landing');
    }
  }
}