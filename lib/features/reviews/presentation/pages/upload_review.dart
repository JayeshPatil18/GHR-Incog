import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/utils/dropdown_items.dart';

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

  FocusNode _focusCategoryNode = FocusNode();

  FocusNode _focusBrandNode = FocusNode();

  final FocusNode _focusSummaryNode = FocusNode();
  bool _hasSummaryFocus = false;

  int rateIndex = -1;

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController summaryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateInput(String? input, int index) {
    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        }
        break;

      case 1:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 10) {
          return 'Description must have at least 10 digit';
        }
        break;

      case 2:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if(!(Items.categorys.contains(input))){
          return 'Category not exist';
        }
        break;

      case 3:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if(!(Items.brands.contains(input))){
          return 'Brand not exist';
        }
        break;

      case 4:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 10) {
          return 'Description must have at least 10 digit';
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
            onPressed: () {
              if(rateIndex == -1){
                setState(() {
                  rateIndex = -2;
                });
              }
              _formKey.currentState!.validate();
            },
            child: Icon(Icons.check_rounded,
                color: AppColors.primaryColor30, size: 38),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,
                          color: AppColors.textColor, size: 28),
                    ),
                    SizedBox(width: 10),
                    Text('Review', style: pageTitleText()),
                  ],
                ),
              ),
            )),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                                style: filterText(
                                    color: AppColors.primaryColor30)),
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
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 0);
                          }),
                          style: textFieldText(),
                          focusNode: _focusNameNode,
                          cursorHeight: TextCursorHeight.cursorHeight,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 20, right: 20),
                            fillColor: AppColors.primaryColor30,
                            filled: true,
                            hintText:
                                _hasNameFocus ? 'Enter product name' : null,
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
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child: Text('Description', style: lableText()),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 1);
                          }),
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
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child: Text('Category', style: lableText()),
                      ),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == "") {
                            return Items.categorys;
                          }
                          return Items.categorys.where((String element) {
                            return element
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String item) {},
                        optionsViewBuilder: ((context, onSelected, options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                width: (MediaQuery.of(context).size.width) - 40,
                                height: 450,
                                color: AppColors.primaryColor30,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(6),
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final String option =
                                        options.elementAt(index);

                                    return InkWell(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        tileColor: AppColors.primaryColor30,
                                        title: Text(option,
                                            style: suggestionText()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          categoryController = textEditingController;
                          _focusCategoryNode = focusNode;

                          return Container(
                            decoration: BoxDecoration(
                                boxShadow: ContainerShadow.boxShadow),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 2);
                              }),
                              controller: categoryController,
                              focusNode: _focusCategoryNode,
                              onEditingComplete: onFieldSubmitted,
                              style: textFieldText(),
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText: 'Select Category',
                                hintStyle: hintFieldText(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width:
                                            AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width:
                                            AppBoarderWidth.reviewUploadWidth,
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
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child: Text('Brand', style: lableText()),
                      ),
                      Autocomplete(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == "") {
                            return Items.brands;
                          }
                          return Items.brands.where((String element) {
                            return element
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          });
                        },
                        onSelected: (String item) {},
                        optionsViewBuilder: ((context, onSelected, options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              child: Container(
                                width: (MediaQuery.of(context).size.width) - 40,
                                height: 450,
                                color: AppColors.primaryColor30,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(6),
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final String option =
                                        options.elementAt(index);

                                    return InkWell(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        tileColor: AppColors.primaryColor30,
                                        title: Text(option,
                                            style: suggestionText()),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                        fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) {
                          brandController = textEditingController;
                          _focusBrandNode = focusNode;
                          return Container(
                            decoration: BoxDecoration(
                                boxShadow: ContainerShadow.boxShadow),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 3);
                              }),
                              controller: brandController,
                              focusNode: _focusBrandNode,
                              onEditingComplete: onFieldSubmitted,
                              style: textFieldText(),
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText: 'Select Brand',
                                hintStyle: hintFieldText(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width:
                                            AppBoarderWidth.reviewUploadWidth,
                                        color: AppBoarderColor.searchBarColor)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.reviewUploadRadius),
                                    borderSide: BorderSide(
                                        width:
                                            AppBoarderWidth.reviewUploadWidth,
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
                          );
                        },
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
                                color: rateIndex != -2 ? AppColors.secondaryColor10 : AppColors.errorColor,
                                width: rateIndex != -2 ? AppBoarderWidth.reviewUploadWidth : AppBoarderWidth.searchBarWidth)),
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
                                        _focusCategoryNode.unfocus();
                                        _focusBrandNode.unfocus();
                                      });
                                    },
                                    child: Icon(Icons.star,
                                        size: 30,
                                        color: rateIndex < index
                                            ? AppColors.iconLightColor
                                            : AppColors.starColor),
                                  ),
                                  SizedBox(width: 10)
                                ],
                              );
                            },
                          ),
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
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 4);
                          }),
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
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    AppBoarderRadius.reviewUploadRadius),
                                borderSide: BorderSide(
                                    width: AppBoarderWidth.searchBarWidth,
                                    color: AppBoarderColor.errorColor)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
