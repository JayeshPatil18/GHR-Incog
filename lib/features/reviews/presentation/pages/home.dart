import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/elevation.dart';
import 'package:review_app/constants/icon_size.dart';
import 'package:review_app/features/authentication/presentation/widgets/choose_gender.dart';
import 'package:review_app/features/reviews/data/repositories/review_repo.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/dropdown.dart';
import 'package:review_app/features/reviews/presentation/widgets/review_model.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/main.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/values.dart';
import '../../../../utils/dropdown_items.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../bloc/fetch_review/fetch_review_bloc.dart';
import '../bloc/fetch_review/fetch_review_event.dart';
import '../bloc/fetch_review/fetch_review_state.dart';
import '../widgets/line.dart';
import '../widgets/loginRequiredBottomSheet.dart';
import '../widgets/post_model.dart';
import '../widgets/sort_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String selectedSort = 'date_des';
  static String searchText = '';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  LoginRequiredState loginRequiredObj = LoginRequiredState();

  final FocusNode _focusNode = FocusNode();

  static String selectedCategory = 'null';
  static String selectedBrand = 'null';

  TextEditingController searchTextController = TextEditingController();

  _setCatBrand() async {
    CategoryBrandsRepo categoryBrandsRepo = CategoryBrandsRepo();
    List<String> category = await categoryBrandsRepo.getCategorys();
    List<String> brand = await categoryBrandsRepo.getBrands();

    setState(() {
      Items.categorys = category;
      Items.brands = brand;
    });
  }

  static Stream reviewStream = ReviewRepo.reviewFireInstance
      .orderBy(
      HomePage.selectedSort.contains('date')
          ? 'date'
          : HomePage.selectedSort.contains('rate')
          ? 'rating'
          : 'date',
      descending: HomePage.selectedSort.contains('asc') ? false : true)
      .snapshots();

  changeReviewInstance(String selectedCategory, String selectedBrand,
      String selectedSort) {

    setState(() {
      if (Items.categorys.contains(selectedCategory) &&
          Items.brands.contains(selectedBrand)) {
        reviewStream = ReviewRepo.reviewFireInstance
            .where('category', isEqualTo: selectedCategory)
            .where('brand', isEqualTo: selectedBrand)
            .orderBy(
            selectedSort.contains('date')
                ? 'date'
                : selectedSort.contains('rate')
                ? 'rating'
                : 'date',
            descending: selectedSort.contains('asc') ? false : true)
            .snapshots();
      } else if (Items.categorys.contains(selectedCategory) &&
          !(Items.brands.contains(selectedBrand))) {
        print('#####${selectedCategory}');
        reviewStream = ReviewRepo.reviewFireInstance
            .where('category', isEqualTo: selectedCategory)
            .orderBy(
            selectedSort.contains('date')
                ? 'date'
                : selectedSort.contains('rate')
                ? 'rating'
                : 'date',
            descending: selectedSort.contains('asc') ? false : true)
            .snapshots();
      } else if (!(Items.categorys.contains(selectedCategory)) &&
          Items.brands.contains(selectedBrand)) {
        reviewStream = ReviewRepo.reviewFireInstance
            .where('brand', isEqualTo: selectedBrand)
            .orderBy(
            selectedSort.contains('date')
                ? 'date'
                : selectedSort.contains('rate')
                ? 'rating'
                : 'date',
            descending: selectedSort.contains('asc') ? false : true)
            .snapshots();
      } else {
        reviewStream = ReviewRepo.reviewFireInstance
            .orderBy(
            selectedSort.contains('date')
                ? 'date'
                : selectedSort.contains('rate')
                ? 'rating'
                : 'date',
            descending: selectedSort.contains('asc') ? false : true)
            .snapshots();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setCatBrand();
    MyApp.initUserId();
    _focusNode.addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchReviewBloc>(context).add(FetchReview());
    MyApp.initUserId();
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(gradient: AppColors.mainGradient),
          margin: EdgeInsets.only(top: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.only(top: 28, left: 20, right: 20),
                    width: double.infinity,
                    height: 100,
                    color: Colors.white,
                    child: Text('Settings', style: MainFonts.pageTitleText()),
                  ),
                  InkWell(
                    onTap: () {
                      if(MyApp.userId == -1){
                        loginRequiredObj.showLoginRequiredDialog(context);
                      } else{
                        Navigator.of(context).pushNamed('editprofile');
                      }
                    },
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: AppColors.textColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('Edit Profile',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppColors.secondaryColor10,
                            ),
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: AppColors.iconLightColor,
                    width: double.infinity,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      if(MyApp.userId == -1){
                        loginRequiredObj.showLoginRequiredDialog(context);
                      } else{
                        Navigator.of(context).pushNamed('changephoneno');
                      }
                    },
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.numbers,
                                  size: 20,
                                  color: AppColors.textColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('Change Phone number',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppColors.secondaryColor10,
                            ),
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: AppColors.iconLightColor,
                    width: double.infinity,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      if(MyApp.userId == -1){
                        loginRequiredObj.showLoginRequiredDialog(context);
                      } else{
                        Navigator.of(context).pushNamed('updatepassowrd');
                      }
                    },
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lock_outlined,
                                  size: 20,
                                  color: AppColors.textColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('Update Password',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppColors.secondaryColor10,
                            ),
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: AppColors.iconLightColor,
                    width: double.infinity,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              title: Text('Want to ${MyApp.userId == -1 ? 'Login' : 'Logout'}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    clearSharedPrefs();
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                    Navigator.of(context)
                                        .pushReplacementNamed('login');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  MyApp.userId == -1 ? Icons.login_rounded : Icons.logout_rounded,
                                  size: 20,
                                  color: AppColors.textColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('${MyApp.userId == -1 ? 'Login' : 'Logout'}',
                                      style: MainFonts.settingLabel()),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: AppColors.secondaryColor10,
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                  EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Image.asset('assets/icons/menu.png',
                            color: AppColors.primaryColor30,
                            height: 34, width: 34),
                      ),

                      // **********************************************************
                      // notification comment
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('notification');
                        },
                        child: Image.asset(
                            'assets/icons/notification.png',
                            height: AppIconSize.appIcons,
                            width: AppIconSize.appIcons),
                      )
                      // **********************************************************
                    ],
                  ),
                ),
                Line()
              ],
            ),
          )),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        margin: EdgeInsets.only(top: 80),
        child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: ReviewRepo.reviewFireInstance.orderBy('date', descending: true).snapshots(),
                builder: (context, snapshot) {
                  final documents;
                  if (snapshot.data != null) {
                    documents = snapshot.data!.docs;
                    if(documents.length < 1){
                      return Center(child: Text('No Post', style: MainFonts.filterText(color: AppColors.textColor)));
                    }
                    return ListView.builder(
                        padding: EdgeInsets.only(bottom: 100),
                        itemCount: documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          UploadReviewModel post =
                              UploadReviewModel.fromMap(documents[index]
                                  .data() as Map<String, dynamic>);

                          return PostModel(
                            date: post.date,
                            likedBy: post.likedBy,
                            mediaUrl: post.mediaUrl,
                            gender: post.gender,
                            userProfileUrl: post.userProfileUrl,
                            parentId: post.parentId,
                            postId: post.postId,
                            text: post.text,
                            userId: post.userId,
                            username: post.username,
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
      ),
    );
  }

  void showGenderDialog(BuildContext context) {
    showModalBottomSheet(
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
                  initialChildSize: 0.80,
                  maxChildSize: 0.80,
                  builder: (context, scrollContoller) =>
                      SingleChildScrollView(
                        child: SortCard(),
                      )),
            )).whenComplete(_onBottomSheetClosed);
  }

  void showSortDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) =>
            DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.60,
                maxChildSize: 0.60,
                builder: (context, scrollContoller) =>
                    SingleChildScrollView(
                      child: SortCard(),
                    ))).whenComplete(_onBottomSheetClosed);
  }

  void showBrandDialog(BuildContext context) {
    TextEditingController brandController = TextEditingController();

    FocusNode focusBrandNode = FocusNode();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) =>
            DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.80,
                maxChildSize: 0.90,
                minChildSize: 0.60,
                builder: (context, scrollContoller) =>
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              width: 60,
                              height: 7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.iconLightColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                                  child:
                                  Text('Brand', style: MainFonts.lableText()),
                                ),
                                Autocomplete(
                                  initialValue: TextEditingValue(
                                      text: Items.brands.contains(selectedBrand)
                                          ? selectedBrand
                                          : ''),
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == "") {
                                      return Items.brands;
                                    }
                                    return Items.brands.where((String element) {
                                      return element.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  onSelected: (String item) {},
                                  optionsViewBuilder:
                                  ((context, onSelected, options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width:
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .width) -
                                              40,
                                          height:
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .height) -
                                              340,
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
                                                  tileColor:
                                                  AppColors.primaryColor30,
                                                  title: Text(option,
                                                      style: MainFonts
                                                          .suggestionText()),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode, onFieldSubmitted) {
                                    brandController = textEditingController;
                                    focusBrandNode = focusNode;

                                    return Container(
                                      decoration: BoxDecoration(
                                          boxShadow: ContainerShadow.boxShadow),
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: ((value) {
                                          selectedBrand =
                                              value.toString()
                                                  .trim();
                                          if (value == null || value.isEmpty) {
                                            return 'Field empty';
                                          } else if (!(Items.brands
                                              .contains(selectedBrand))) {
                                            return 'Brand not exist';
                                          }
                                        }),
                                        controller: brandController,
                                        focusNode: focusBrandNode,
                                        onEditingComplete: onFieldSubmitted,
                                        style: MainFonts.textFieldText(),
                                        cursorHeight: TextCursorHeight
                                            .cursorHeight,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                brandController.text = '';
                                              },
                                              child: Icon(Icons.clear_rounded)),
                                          contentPadding: EdgeInsets.only(
                                              top: 16,
                                              bottom: 16,
                                              left: 20,
                                              right: 20),
                                          fillColor: AppColors.primaryColor30,
                                          filled: true,
                                          hintText: 'Select Brand',
                                          hintStyle: MainFonts.hintFieldText(),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .reviewUploadWidth,
                                                  color: AppBoarderColor
                                                      .searchBarColor)),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .reviewUploadWidth,
                                                  color: AppBoarderColor
                                                      .searchBarColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .searchBarWidth,
                                                  color: AppBoarderColor
                                                      .searchBarColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .searchBarWidth,
                                                  color:
                                                  AppBoarderColor.errorColor)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))).whenComplete(_onBottomSheetClosed);
  }

  void showCategoryDialog(BuildContext context) {
    TextEditingController categoryController = TextEditingController();

    FocusNode focusCategoryNode = FocusNode();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) =>
            DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.80,
                maxChildSize: 0.90,
                minChildSize: 0.60,
                builder: (context, scrollContoller) =>
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              width: 60,
                              height: 7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.iconLightColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                                  child: Text('Category',
                                      style: MainFonts.lableText()),
                                ),
                                Autocomplete(
                                  initialValue: TextEditingValue(
                                      text:
                                      Items.categorys.contains(selectedCategory)
                                          ? selectedCategory
                                          : ''),
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == "") {
                                      return Items.categorys;
                                    }
                                    return Items.categorys.where((
                                        String element) {
                                      return element.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  onSelected: (String item) {},
                                  optionsViewBuilder:
                                  ((context, onSelected, options) {
                                    return Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width:
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .width) -
                                              40,
                                          height:
                                          (MediaQuery
                                              .of(context)
                                              .size
                                              .height) -
                                              340,
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
                                                  tileColor:
                                                  AppColors.primaryColor30,
                                                  title: Text(option,
                                                      style: MainFonts
                                                          .suggestionText()),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  fieldViewBuilder: (context,
                                      textEditingController,
                                      focusNode, onFieldSubmitted) {
                                    categoryController = textEditingController;
                                    focusCategoryNode = focusNode;

                                    return Container(
                                      decoration: BoxDecoration(
                                          boxShadow: ContainerShadow.boxShadow),
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: ((value) {
                                          selectedCategory =
                                              value.toString()
                                                  .trim();
                                          if (value == null || value.isEmpty) {
                                            return 'Field empty';
                                          } else if (!(Items.categorys
                                              .contains(selectedCategory))) {
                                            return 'Category not exist';
                                          }
                                        }),
                                        controller: categoryController,
                                        focusNode: focusCategoryNode,
                                        onEditingComplete: onFieldSubmitted,
                                        style: MainFonts.textFieldText(),
                                        cursorHeight: TextCursorHeight
                                            .cursorHeight,
                                        decoration: InputDecoration(
                                          suffixIcon: InkWell(
                                              onTap: () {
                                                categoryController.text = '';
                                              },
                                              child: Icon(Icons.clear_rounded)),
                                          contentPadding: EdgeInsets.only(
                                              top: 16,
                                              bottom: 16,
                                              left: 20,
                                              right: 20),
                                          fillColor: AppColors.primaryColor30,
                                          filled: true,
                                          hintText: 'Select Category',
                                          hintStyle: MainFonts.hintFieldText(),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .reviewUploadWidth,
                                                  color: AppBoarderColor
                                                      .searchBarColor)),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .reviewUploadWidth,
                                                  color: AppBoarderColor
                                                      .searchBarColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .searchBarWidth,
                                                  color: AppBoarderColor
                                                      .searchBarColor)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(
                                                  AppBoarderRadius
                                                      .reviewUploadRadius),
                                              borderSide: BorderSide(
                                                  width: AppBoarderWidth
                                                      .searchBarWidth,
                                                  color:
                                                  AppBoarderColor.errorColor)),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))).whenComplete(_onBottomSheetClosed);
  }

  void _onBottomSheetClosed() {
    Timer(Duration(milliseconds: AppValues.closeDelay), () {
      changeReviewInstance(
          selectedCategory, selectedBrand, HomePage.selectedSort);
    });
  }

  int calculateSubstringRelevance(String target, String input) {
    // Calculate the length of the common substring
    int maxLength = 0;
    for (int i = 0; i < target.length; i++) {
      for (int j = 0; j < input.length; j++) {
        int k = 0;
        while (i + k < target.length && j + k < input.length && target[i + k] == input[j + k]) {
          k++;
        }
        maxLength = maxLength < k ? k : maxLength;
      }
    }
    return maxLength;
  }
}
