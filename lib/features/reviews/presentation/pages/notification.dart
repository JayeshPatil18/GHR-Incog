import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/line.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/utils/dropdown_items.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/method1.dart';
import '../../../../utils/methods.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/id_argument.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/string_argument.dart';
import '../../domain/entities/two_string_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../bloc/upload_review/upload_review_bloc.dart';
import '../bloc/upload_review/upload_review_event.dart';
import '../widgets/dropdown.dart';
import '../widgets/image_shimmer.dart';
import '../widgets/notification_model.dart';
import '../widgets/post_model.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';
import '../widgets/view_post_model.dart';
import '../widgets/view_replies_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin:
                EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios,
                              color: AppColors.textColor, size: 20),
                        ),
                        SizedBox(width: 10),
                        Text('View Post', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
                      ],
                    ),
                    GestureDetector(
                      onTap: (() {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            title: const Text('Clear all'),
                            content: const Text(
                                'All notifications will be removed.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.transparentComponentColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(
                              30),
                        ),
                        padding: EdgeInsets.only(
                            top: 8, bottom: 8, left: 12, right: 12),
                        child: Text('Clear All',
                            style: MainFonts.filterText(
                                color: AppColors.primaryColor30)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding:
                  EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 90),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return NotificationModel(
                        message: 'Henry Tyson',
                        msgType: 'rank',
                        ago: '10 hours ago');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}