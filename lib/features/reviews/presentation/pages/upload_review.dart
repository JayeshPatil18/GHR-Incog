import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/constants/values.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../widgets/dropdown.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class UploadReview extends StatefulWidget {
  const UploadReview({super.key});

  @override
  State<UploadReview> createState() => _UploadReviewState();
}

class _UploadReviewState extends State<UploadReview> {
  final FocusNode _focusNameNode = FocusNode();
  bool _hasNameFocus = false;

  final FocusNode _focusDescNode = FocusNode();
  bool _hasDescFocus = false;

  final FocusNode _focusSummaryNode = FocusNode();
  bool _hasSummaryFocus = false;

  int rateIndex = -1;

  @override
  void initState() {
    super.initState();
    _focusNameNode.addListener(() {
      setState(() {
        _hasNameFocus = _focusNameNode.hasFocus;
      });
    });

    _focusDescNode.addListener(() {
      setState(() {
        _hasDescFocus = _focusDescNode.hasFocus;
      });
    });

    _focusSummaryNode.addListener(() {
      setState(() {
        _hasSummaryFocus = _focusSummaryNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNameNode.dispose();
    _focusNameNode.dispose();
    _focusNameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 6, right: 6),
          width: 70,
          height: 70,
          child: FloatingActionButton(
          backgroundColor: AppColors.secondaryColor10,
          onPressed: () {},
          child: Icon(Icons.check_rounded, color: AppColors.primaryColor30, size: 38),
        ),
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: SafeArea(
              child: Container(
                alignment: Alignment.centerLeft,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: AppColors.textColor, size: 28),
                    SizedBox(width: 10),
                    Text('Review', style: pageTitleText()),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    boxShadow: ContainerShadow.boxShadow,
                    color: AppColors.primaryColor30,
                    border: Border.all(
                        color: AppBoarderColor.searchBarColor,
                        width: AppBoarderWidth.reviewUploadWidth),
                    borderRadius: BorderRadius.circular(
                        AppBoarderRadius.reviewUploadRadius),
                  ),
                  height: 320,
                  width: double.infinity,
                  margin: EdgeInsets.all(20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 50,
                          color: AppColors.secondaryColor10,
                        ),
                        SizedBox(height: 40),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: ContainerShadow.boxShadow,
                            color: AppColors.secondaryColor10,
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.filterRadius),
                          ),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 16, right: 16),
                          child: Text('Upload Image',
                              style:
                                  filterText(color: AppColors.primaryColor30)),
                        ),
                      ])),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      child: Text('Product Name', style: lableText()),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                      child: TextField(
                        style: textFieldText(),
                        focusNode: _focusNameNode,
                        cursorHeight: TextCursorHeight.cursorHeight,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 16, bottom: 16, left: 20, right: 20),
                          fillColor: AppColors.primaryColor30,
                          filled: true,
                          hintText: _hasNameFocus ? 'Enter product name' : null,
                          hintStyle: hintFieldText(),
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
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      child: Text('Description', style: lableText()),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                      child: TextField(
                        maxLines: 2,
                        style: textFieldText(),
                        focusNode: _focusDescNode,
                        cursorHeight: TextCursorHeight.cursorHeight,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 16, bottom: 16, left: 20, right: 20),
                          fillColor: AppColors.primaryColor30,
                          filled: true,
                          hintText: _hasDescFocus
                              ? 'Enter description of product'
                              : null,
                          hintStyle: hintFieldText(),
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
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      child: Text('Category', style: lableText()),
                    ),
                    GestureDetector(
                      onTap: () {
                        openBottomSheet(context, 0);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 16, bottom: 16, left: 20, right: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: ContainerShadow.boxShadow,
                            color: AppColors.primaryColor30,
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.reviewUploadRadius),
                            border: Border.all(
                                color: AppColors.secondaryColor10,
                                width: AppBoarderWidth.reviewUploadWidth)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Select Category', style: textFieldText()),
                            Icon(Icons.keyboard_arrow_down_rounded,
                                color: AppColors.secondaryColor10, size: 26)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      child: Text('Brand', style: lableText()),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 20, right: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.primaryColor30,
                          borderRadius: BorderRadius.circular(
                              AppBoarderRadius.reviewUploadRadius),
                          border: Border.all(
                              color: AppColors.secondaryColor10,
                              width: AppBoarderWidth.reviewUploadWidth)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Select Brand', style: textFieldText()),
                          Icon(Icons.keyboard_arrow_down_rounded,
                              color: AppColors.secondaryColor10, size: 26)
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      child: Text('Rate', style: lableText()),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 16, left: 20, right: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.primaryColor30,
                          borderRadius: BorderRadius.circular(
                              AppBoarderRadius.reviewUploadRadius),
                          border: Border.all(
                              color: AppColors.secondaryColor10,
                              width: AppBoarderWidth.reviewUploadWidth)),
                      child: SizedBox(
                        height: 30,
                        child: ListView.builder(
                          itemCount: AppValues.maxRating,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) { 
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      rateIndex = index;
                                    });
                                  },
                                  child: Icon(Icons.star, size: 30, color: rateIndex < index ? AppColors.iconLightColor : AppColors.starColor),
                                ),
                                SizedBox(width: 10)
                              ],
                            );
                         },),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5),
                      child: Text('Summary', style: lableText()),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                      child: TextField(
                        maxLines: 4,
                        style: textFieldText(),
                        focusNode: _focusSummaryNode,
                        cursorHeight: TextCursorHeight.cursorHeight,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 16, bottom: 16, left: 20, right: 20),
                          fillColor: AppColors.primaryColor30,
                          filled: true,
                          hintText: _hasSummaryFocus
                              ? 'Write experience of product'
                              : null,
                          hintStyle: hintFieldText(),
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
