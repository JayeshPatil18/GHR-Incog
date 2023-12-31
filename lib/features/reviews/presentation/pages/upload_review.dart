import 'dart:io';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/utils/dropdown_items.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../bloc/upload_review/upload_review_bloc.dart';
import '../bloc/upload_review/upload_review_event.dart';
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

  final FocusNode _focusPriceNode = FocusNode();
  bool _hasPriceFocus = false;

  final FocusNode _focusDescNode = FocusNode();
  bool _hasDescFocus = false;

  FocusNode _focusCategoryNode = FocusNode();

  FocusNode _focusBrandNode = FocusNode();

  final FocusNode _focusSummaryNode = FocusNode();
  bool _hasSummaryFocus = false;

  int rateIndex = -1;
  int hasImagePicked = -1;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController summaryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String priceCurrency = '₹';

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
        } else if(!doesNotContainSpaces(input)){
          return 'Price should not contain any spaces';
        }
        break;

      case 2:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 10) {
          return 'Description must have at least 10 digit';
        }
        break;

      case 3:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (!(Items.categorys.contains(input))) {
          return 'Category not exist';
        }
        break;

      case 4:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (!(Items.brands.contains(input))) {
          return 'Brand not exist';
        }
        break;

      case 5:
        if (input == null || input.isEmpty) {
          return 'Field empty';
        } else if (input.length < 10) {
          return 'Summary must have at least 10 digit';
        }
        break;

      default:
        return null;
    }
  }

  _setCatBrand() async {
    CategoryBrandsRepo categoryBrandsRepo = CategoryBrandsRepo();
    List<String> category = await categoryBrandsRepo.getCategorys();
    List<String> brand = await categoryBrandsRepo.getBrands();
    setState(() {
      Items.categorys = category;
      Items.brands = brand;
    });
  }

  @override
  void initState() {
    super.initState();
    _setCatBrand();
    _focusNameNode.addListener(() {
      setState(() {
        _hasNameFocus = _focusNameNode.hasFocus;
      });
    });

    _focusPriceNode.addListener(() {
      setState(() {
        _hasPriceFocus = _focusPriceNode.hasFocus;
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

  File? _selectedImage;
  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    setState(() {
      hasImagePicked = 1;
      _selectedImage = File(image.path);
    });
  }

  void pickSource() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Gallary'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: AppColors.iconLightColor,
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor60,
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 6, right: 6),
          width: 70,
          height: 70,
          child: BlocConsumer<UploadReviewBloc, UploadReviewState>(
            listener: (context, state) {
              if (state is UploadReviewFaild) {
                mySnackBarShow(context, 'Something went wrong.');
              } else if (state is UploadReviewSuccess) {
                FocusScope.of(context).unfocus();
                mySnackBarShow(context, 'Review Uploaded Successfully.');
                Future.delayed(const Duration(milliseconds: 300), () {
                  Navigator.of(context).pop();
                });
              }
            },
            builder: (context, state) {
              if (state is UploadReviewLoading) {
                return FloatingActionButton(
                    backgroundColor: AppColors.secondaryColor10,
                    onPressed: () {},
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Center(
                            child: CircularProgressIndicator(
                                strokeWidth: AppValues.progresBarWidth,
                                color: AppColors.primaryColor30))));
              }
              return FloatingActionButton(
                  backgroundColor: AppColors.secondaryColor10,
                  onPressed: () {
                    if (rateIndex == -1) {
                      setState(() {
                        rateIndex = -2;
                      });
                    }
                    if (hasImagePicked == -1) {
                      setState(() {
                        hasImagePicked = -2;
                      });
                      mySnackBarShow(context, 'Please Upload Image.');
                    }
                    bool isValid = _formKey.currentState!.validate();
                    if (isValid && rateIndex > 0 && hasImagePicked == 1) {
                      BlocProvider.of<UploadReviewBloc>(context)
                          .add(UploadClickEvent(
                        brand: brandController.text.trim(),
                        category: categoryController.text.trim(),
                        description: descController.text.trim(),
                        imageSelected: _selectedImage!,
                        name: nameController.text.trim(),
                        price: priceCurrency + priceController.text.trim(),
                        rating: rateIndex + 1,
                        summary: summaryController.text.trim(),
                      ));
                    }
                  },
                  child: Icon(Icons.check_rounded,
                      color: AppColors.primaryColor30, size: 38));
            },
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
                          color: AppColors.textColor, size: 26),
                    ),
                    SizedBox(width: 10),
                    Text('Review', style: MainFonts.pageTitleText()),
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
                GestureDetector(
                  onTap: () {
                    pickSource();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                        color: AppColors.primaryColor30,
                        border: Border.all(
                            color: hasImagePicked != -2
                                ? AppColors.secondaryColor10
                                : AppColors.errorColor,
                            width: hasImagePicked != -2
                                ? AppBoarderWidth.reviewUploadWidth
                                : AppBoarderWidth.searchBarWidth),
                        borderRadius: BorderRadius.circular(
                            AppBoarderRadius.reviewUploadRadius),
                      ),
                      height: 320,
                      width: double.infinity,
                      margin: EdgeInsets.all(20),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.reviewUploadRadius),
                              child: Stack(
                                children: [
                                  Center(
                                      child: Image(
                                          image: FileImage(_selectedImage!))),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor10,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.file_upload_outlined,
                                          color: AppColors.primaryColor30),
                                    ),
                                  )
                                ],
                              ))
                          : Column(
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
                                        top: 10,
                                        bottom: 10,
                                        left: 16,
                                        right: 16),
                                    child: Text('Upload Image',
                                        style: MainFonts.filterText(
                                            color: AppColors.primaryColor30)),
                                  ),
                                ])),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child:
                            Text('Product Name', style: MainFonts.lableText()),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 0);
                          }),
                          style: MainFonts.textFieldText(),
                          controller: nameController,
                          focusNode: _focusNameNode,
                          cursorHeight: TextCursorHeight.cursorHeight,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 20, right: 20),
                            fillColor: AppColors.primaryColor30,
                            filled: true,
                            hintText:
                                _hasNameFocus ? 'Enter product name' : null,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child: Text('Price', style: MainFonts.lableText()),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 1);
                          }),
                          keyboardType: TextInputType.number,
                          style: MainFonts.textFieldText(),
                          controller: priceController,
                          focusNode: _focusPriceNode,
                          cursorHeight: TextCursorHeight.cursorHeight,
                          decoration: InputDecoration(
                            prefixIcon: GestureDetector(
                                onTap: (() {
                                  showCurrencyPicker(
                                    context: context,
                                    theme: CurrencyPickerThemeData(
                                      flagSize: 25,
                                      titleTextStyle: TextStyle(fontSize: 17),
                                      subtitleTextStyle: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).hintColor),
                                      bottomSheetHeight:
                                          MediaQuery.of(context).size.height /
                                              1.8,
                                    ),
                                    favorite: ['INR'],
                                    onSelect: (Currency currency) =>
                                        setState(() {
                                      priceCurrency =
                                          currency.symbol.toString();
                                    }),
                                  );
                                }),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 16, bottom: 16, left: 10),
                                  child: Text(priceCurrency,
                                      style: MainFonts.textFieldText(),
                                      textAlign: TextAlign.center),
                                )),
                            contentPadding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 20, right: 20),
                            fillColor: AppColors.primaryColor30,
                            filled: true,
                            hintText:
                                _hasPriceFocus ? 'Enter product price' : null,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child:
                            Text('Description', style: MainFonts.lableText()),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 2);
                          }),
                          maxLines: 2,
                          style: MainFonts.textFieldText(),
                          controller: descController,
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, left: 5),
                        child: Text('Category', style: MainFonts.lableText()),
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
                                            style: MainFonts.suggestionText()),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 3);
                              }),
                              controller: categoryController,
                              focusNode: _focusCategoryNode,
                              onEditingComplete: onFieldSubmitted,
                              style: MainFonts.textFieldText(),
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText: 'Select Category',
                                hintStyle: MainFonts.hintFieldText(),
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
                        child: Text('Brand', style: MainFonts.lableText()),
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
                                            style: MainFonts.suggestionText()),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: ((value) {
                                return _validateInput(value, 4);
                              }),
                              controller: brandController,
                              focusNode: _focusBrandNode,
                              onEditingComplete: onFieldSubmitted,
                              style: MainFonts.textFieldText(),
                              cursorHeight: TextCursorHeight.cursorHeight,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 16, bottom: 16, left: 20, right: 20),
                                fillColor: AppColors.primaryColor30,
                                filled: true,
                                hintText: 'Select Brand',
                                hintStyle: MainFonts.hintFieldText(),
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
                        child: Text('Rate', style: MainFonts.lableText()),
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
                                color: rateIndex != -2
                                    ? AppColors.secondaryColor10
                                    : AppColors.errorColor,
                                width: rateIndex != -2
                                    ? AppBoarderWidth.reviewUploadWidth
                                    : AppBoarderWidth.searchBarWidth)),
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
                        child: Text('Summary', style: MainFonts.lableText()),
                      ),
                      Container(
                        decoration:
                            BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: ((value) {
                            return _validateInput(value, 5);
                          }),
                          maxLines: 4,
                          style: MainFonts.textFieldText(),
                          controller: summaryController,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
