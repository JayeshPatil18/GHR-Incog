import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:review_app/constants/color.dart';
import 'package:review_app/constants/icon_size.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';

import '../../../../constants/boarder_radius.dart';
import '../../../../utils/fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                CircleIconContainer(containerColor: AppColors.textColor, containerSize: 44, icon: Image.asset('assets/icons/notification.png', height: AppIconSize.bottomNavBarIcons, width: AppIconSize.bottomNavBarIcons))
              ],
            ),
            SizedBox(height: 40),
            TextField(
                  style: textFieldText(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 16, bottom: 16, left: 20, right: 20),
                fillColor: AppColors.primaryColor30,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppBoarderRadius.searchBarRadius)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}