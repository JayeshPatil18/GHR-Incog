import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/constants/color.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/fonts.dart';
import 'shadow.dart';


class SelectBottomSheet extends StatefulWidget {
  final int index;

  const SelectBottomSheet({required this.index});

  @override
  State<StatefulWidget> createState() {
    return SelectBottomSheetState();
  }
}

class SelectBottomSheetState extends State<SelectBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 30),
            width: 60,
            height: 7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.iconLightColor),
          ),
          Container(
                      decoration:
                          BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                      child: TextField(
                        style: MainFonts.textFieldText(),
                        cursorHeight: TextCursorHeight.cursorHeight,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 16, bottom: 16, left: 20, right: 20),
                          fillColor: AppColors.primaryColor30,
                          filled: true,
                          hintText: widget.index == 0 ? 'Search Category' : 'Search Brand',
                          hintStyle: MainFonts.hintFieldText(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.reviewUploadRadius),
                              borderSide: BorderSide(
                                  width: AppBoarderWidth.searchBarWidth,
                                  color: AppBoarderColor.searchBarColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.reviewUploadRadius),
                              borderSide: BorderSide(
                                  width: AppBoarderWidth.searchBarWidth,
                                  color: AppBoarderColor.searchBarColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.reviewUploadRadius),
                              borderSide: BorderSide(
                                  width: AppBoarderWidth.searchBarWidth,
                                  color: AppBoarderColor.searchBarColor)),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
