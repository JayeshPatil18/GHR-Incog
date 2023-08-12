import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/icon_size.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/dropdown.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/fonts.dart';
import '../widgets/sort_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  String selectedItem = 'Option 1';

  void _showDropdown() async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              ListTile(
                title: Text('Option 1'),
                onTap: () {
                  setState(() {
                    selectedItem = 'Option 1';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Option 2'),
                onTap: () {
                  setState(() {
                    selectedItem = 'Option 2';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Option 3'),
                onTap: () {
                  setState(() {
                    selectedItem = 'Option 3';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/icons/menu.png', height: 34, width: 34),
                    CircleIconContainer(
                        containerColor: AppColors.textColor,
                        containerSize: 44,
                        icon: Image.asset('assets/icons/notification.png',
                            height: AppIconSize.bottomNavBarIcons,
                            width: AppIconSize.bottomNavBarIcons))
                  ],
                ),
                SizedBox(height: 40),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow
                      ),
                      child: TextField(
                      style: textFieldText(),
                      focusNode: _focusNode,
                      cursorHeight: TextCursorHeight.cursorHeight,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 80),
                        fillColor: AppColors.primaryColor30,
                        filled: true,
                        hintText: _hasFocus ? 'Search Products' : null,
                        hintStyle: hintFieldText(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppBoarderRadius.searchBarRadius),
                          borderSide: const BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppBoarderRadius.searchBarRadius),
                          borderSide: BorderSide(
                            width: AppBoarderWidth.searchBarWidth,
                            color: AppBoarderColor.searchBarColor
                          )
                        ),
                      ),
                  ),
                    ),
                  Positioned(
                      right: 8,
                      child: CircleIconContainer(icon: const Icon(Icons.search, color: AppColors.primaryColor30), containerColor: AppColors.secondaryColor10, containerSize: 40)
                    ),
                  ],
                ),
                  ],
                ),
              ),
                  ]
                ),
              )
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                        color: AppColors.textColor,
                        borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius),
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
                      child: Text('All', style: filterText(color: AppColors.primaryColor30)),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                        color: AppColors.primaryColor30,
                        borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius
                        ),
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
                      child: Text('Category', style: filterText(color: AppColors.textColor)),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                        color: AppColors.primaryColor30,
                        borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius
                        ),
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
                      child: Text('Brand', style: filterText(color: AppColors.textColor)),
                    ),
                    SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: ContainerShadow.boxShadow,
                        color: AppColors.primaryColor30,
                        borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius
                        ),
                      ),
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 13),
                      child: Text('Rating', style: filterText(color: AppColors.textColor)),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                        showSortDialog(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: ContainerShadow.boxShadow,
                          color: AppColors.backgroundColor60,
                          borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius
                          ),
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 11, right: 11),
                        child: Icon(Icons.sort_rounded, color: AppColors.textColor),
                      ),
                    ),
                  ],
                )
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
}
