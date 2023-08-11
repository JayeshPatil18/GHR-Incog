import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/icon_size.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/dropdown.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../constants/boarder.dart';
import '../../../../utils/fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

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
      body: Container(
        margin: EdgeInsets.only(top: 70, left: 20, right: 20),
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
            SizedBox(height : 20),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: ContainerShadow.boxShadow,
                    color: AppColors.textColor,
                    borderRadius: BorderRadius.circular(AppBoarderRadius.filterRadius),
                  ),
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14),
                  child: Text('All', style: filterText()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
