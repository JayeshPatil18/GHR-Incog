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
import 'package:review_app/features/reviews/domain/entities/notification.dart';
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
import '../../../authentication/data/repositories/users_repo.dart';
import '../../data/repositories/category_brand_repo.dart';
import '../../data/repositories/review_repo.dart';
import '../../domain/entities/id_argument.dart';
import '../../domain/entities/image_argument.dart';
import '../../domain/entities/string_argument.dart';
import '../../domain/entities/two_string_argument.dart';
import '../../domain/entities/upload_review.dart';
import '../../domain/entities/user.dart';
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
                        Text('Notifications', style: MainFonts.pageTitleText(fontSize: 22, weight: FontWeight.w400)),
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
                          color: AppColors.transparentComponentColor.withOpacity(0.1),
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
                child: StreamBuilder<QuerySnapshot>(
                    stream: UsersRepo.userFireInstance.snapshots(),
                    builder: (context, snapshot) {
                      final documents;
                      documents = snapshot.data?.docs;
                      List<Map<String, dynamic>> usersData = [];
                      User? user;

                      if (documents != null && documents.isNotEmpty) {
                        final firstDocument = documents[0];

                        if (firstDocument != null &&
                            firstDocument.data() != null &&
                            firstDocument.data().containsKey('userslist')) {
                          usersData = List<Map<String, dynamic>>.from(
                              firstDocument.data()['userslist']);

                          List<User> usersList =
                          usersData.map((userData) => User.fromMap(userData)).toList();

                          List<User> users =
                          usersList.where((user) => user.uid == MyApp.userId).toList();
                          user = users.first;

                          List<MyNotification>? notifications = user.notifications;

                          if(notifications != null && notifications.isNotEmpty){

                            return ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (context, value) {
                                MyNotification notification = notifications[value];
                                return NotificationModel(message: notification.message, msgType: notification.msgType, ago: notification.date);
                              },
                            );
                          }
                        }
                      }
                      return Center(child: Text('No Notification', style: MainFonts.filterText(color: AppColors.lightTextColor)));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}