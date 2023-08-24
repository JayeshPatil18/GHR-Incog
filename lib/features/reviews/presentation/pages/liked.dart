import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../utils/fonts.dart';
import '../widgets/review_model.dart';
import '../widgets/shadow.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Liked', style: MainFonts.pageTitleText()),
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
                                'All Likes will be removed.'),
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
                            boxShadow: ContainerShadow.boxShadow,
                            color: AppColors.textColor,
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.filterRadius),
                          ),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 13, right: 13),
                          child: Text('Clear All',
                              style: MainFonts.filterText(color: AppColors.primaryColor30)),
                        ),
                  ),
                ],
              ),
            ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(top: 10, bottom: 100, left: 20, right: 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        childAspectRatio: (100/158)
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewModel(imageUrl : 'https://static.vecteezy.com/system/resources/thumbnails/021/690/601/small/bright-sun-shines-on-green-morning-grassy-meadow-bright-blue-sky-ai-generated-image-photo.jpg', price : '100', isLiked : true, title : 'Apple iPhone 14 Pro', brand : 'Apple', category : 'Smart Phones', date : '12/04/2023', rating : 3);
                      }),
                ),
          ],
        ),
      )
    );
  }
}