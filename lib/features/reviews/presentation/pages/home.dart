import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/icon_size.dart';
import 'package:review_app/features/reviews/data/repositories/review_repo.dart';
import 'package:review_app/features/reviews/presentation/pages/upload_review.dart';
import 'package:review_app/features/reviews/presentation/widgets/brand_filter.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/dropdown.dart';
import 'package:review_app/features/reviews/presentation/widgets/review_model.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';
import 'package:review_app/main.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/dropdown_items.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../../domain/entities/upload_review.dart';
import '../bloc/fetch_review/fetch_review_bloc.dart';
import '../bloc/fetch_review/fetch_review_event.dart';
import '../bloc/fetch_review/fetch_review_state.dart';
import '../widgets/category_filter.dart';
import '../widgets/sort_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  static String selectedCategory = '';
  static String selectedBrand = '';

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
    MyApp.initUserId();
    _focusNode.addListener(() {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
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
        backgroundColor: Colors.white,
        child: Container(
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
                      Navigator.of(context).pushNamed('editprofile');
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
                      Navigator.of(context).pushNamed('changephoneno');
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
                      Navigator.of(context).pushNamed('updatepassowrd');
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
                  InkWell(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          contentPadding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: const Text('Want to Logout?'),
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
                                  Icons.lock_outlined,
                                  size: 20,
                                  color: AppColors.textColor,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text('Logout',
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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Image.asset('assets/icons/menu.png',
                                  height: 34, width: 34),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed('notification');
                              },
                              child: CircleIconContainer(
                                  containerColor: AppColors.textColor,
                                  containerSize: 44,
                                  icon: Image.asset(
                                      'assets/icons/notification.png',
                                      height: AppIconSize.bottomNavBarIcons,
                                      width: AppIconSize.bottomNavBarIcons)),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: ContainerShadow.boxShadow),
                              child: TextField(
                                style: MainFonts.textFieldText(),
                                focusNode: _focusNode,
                                cursorHeight: TextCursorHeight.cursorHeight,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 16, bottom: 16, left: 20, right: 80),
                                  fillColor: AppColors.primaryColor30,
                                  filled: true,
                                  hintText:
                                      _hasFocus ? 'Search Products' : null,
                                  hintStyle: MainFonts.hintFieldText(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppBoarderRadius.searchBarRadius),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppBoarderRadius.searchBarRadius),
                                      borderSide: BorderSide(
                                          width: AppBoarderWidth.searchBarWidth,
                                          color:
                                              AppBoarderColor.searchBarColor)),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 8,
                                child: CircleIconContainer(
                                    icon: const Icon(Icons.search,
                                        color: AppColors.primaryColor30),
                                    containerColor: AppColors.secondaryColor10,
                                    containerSize: 40)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              boxShadow: ContainerShadow.boxShadow,
                              color: AppColors.textColor,
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.filterRadius),
                            ),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 13, right: 13),
                            child: Text('All',
                                style: MainFonts.filterText(
                                    color: AppColors.primaryColor30)),
                          ),
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            showCategoryDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: ContainerShadow.boxShadow,
                              color: AppColors.primaryColor30,
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.filterRadius),
                            ),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 13, right: 13),
                            child: Text('Category',
                                style:
                                    MainFonts.filterText(color: AppColors.textColor)),
                          ),
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            showBrandDialog(context, _HomePageState.selectedBrand);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: ContainerShadow.boxShadow,
                              color: AppColors.primaryColor30,
                              borderRadius: BorderRadius.circular(
                                  AppBoarderRadius.filterRadius),
                            ),
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 13, right: 13),
                            child: Text('Brand',
                                style:
                                    MainFonts.filterText(color: AppColors.textColor)),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(width: 12),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     boxShadow: ContainerShadow.boxShadow,
                    //     color: AppColors.primaryColor30,
                    //     borderRadius: BorderRadius.circular(
                    //         AppBoarderRadius.filterRadius),
                    //   ),
                    //   padding: EdgeInsets.only(
                    //       top: 10, bottom: 10, left: 13, right: 13),
                    //   child: Text('Rating',
                    //       style:
                    //           MainFonts.filterText(color: AppColors.textColor)),
                    // ),
                    // SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        showSortDialog(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.backgroundColor60,
                          borderRadius: BorderRadius.circular(
                              AppBoarderRadius.filterRadius),
                        ),
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 7, right: 7),
                        child: Icon(Icons.sort_rounded,
                            color: AppColors.textColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: ReviewRepo.reviewFireInstance.snapshots(),
                        builder: (context, snapshot) {
                          final documents;
                          if (snapshot.data != null) {
                            documents = snapshot.data!.docs;
                            if(documents.length < 1){
                              return Center(child: Text('No Reviews', style: MainFonts.filterText(color: AppColors.textColor)));
                            }
                            return GridView.builder(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 100, left: 20, right: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                        crossAxisCount: 2,
                                        childAspectRatio: (100 / 158)),
                                scrollDirection: Axis.vertical,
                                itemCount: documents.length,
                                itemBuilder: (BuildContext context, int index) {
                                  UploadReviewModel review =
                                      UploadReviewModel.fromMap(documents[index]
                                          .data() as Map<String, dynamic>);

                                  return ReviewModel(
                                      reviewId: review.rid,
                                      imageUrl: review.imageUrl,
                                      price: review.price,
                                      isLiked: review.likedBy.contains(MyApp.userId),
                                      title: review.name,
                                      brand: review.brand,
                                      category: review.category,
                                      date: review.date
                                          .substring(0, 10)
                                          .replaceAll('-', '/'),
                                      rating: review.rating);
                                });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSortDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.60,
            maxChildSize: 0.60,
            builder: (context, scrollContoller) => SingleChildScrollView(
                  child: SortCard(),
                )));
  }

  void showBrandDialog(BuildContext context, String brand) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.80,
          maxChildSize: 0.90,
          minChildSize: 0.60,
            builder: (context, scrollContoller) => SingleChildScrollView(
                  child: BrandFilter(),
                )));
  }

  void showCategoryDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.80,
          maxChildSize: 0.90,
          minChildSize: 0.60,
            builder: (context, scrollContoller) => SingleChildScrollView(
                  child: CategoryFilter(),
                )));
  }
}
