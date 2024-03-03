import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/elevation.dart';
import '../../../../main.dart';
import '../../../../utils/fonts.dart';
import '../../../../utils/methods.dart';
import '../pages/edit_profile.dart';
import 'image_shimmer.dart';

class ChooseProfileIcon extends StatefulWidget {
  const ChooseProfileIcon({super.key});

  @override
  State<ChooseProfileIcon> createState() => _ChooseProfileIconState();
}

class _ChooseProfileIconState extends State<ChooseProfileIcon> {

  @override
  void initState() {
    setState(() {
      getAllImageURLs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        minChildSize: 0.40,
        builder: (context, scrollContoller) =>
            TimerBuilder.periodic(Duration(seconds: 1), //updates every second
                builder: (context) {
                  return Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.mainGradient
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                              color: AppColors.transparentComponentColor),
                        ),
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                            child: Text('Select Profile Picture', style: MainFonts.lableText(color: AppColors.primaryColor30))),
                        Expanded(
                          child: MyApp.profileIconList.isNotEmpty ? GridView.builder(
                              padding: EdgeInsets.only(right: 20, left: 20,
                                  bottom: 20, top: 10),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 45,
                                mainAxisSpacing: 45,
                                crossAxisCount: 3,),
                              scrollDirection: Axis.vertical,
                              itemCount: MyApp.profileIconList.length,
                              itemBuilder: (BuildContext context,
                                  int index) {
                                String iconUrl =
                                MyApp.profileIconList[index];

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      EditProfileState.profileImageUrl = iconUrl;
                                    });
                                  },
                                  child: iconUrl == EditProfileState.profileImageUrl ? Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primaryColor30,
                                            width: 3.0,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: AppColors.primaryColor30,
                                          radius: 50,
                                          child: ClipOval(
                                            child: CustomImageShimmer(
                                                imageUrl: iconUrl,
                                                width: double.infinity,
                                                height: double.infinity,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor30,
                                              shape: BoxShape
                                                  .circle,
                                            ),
                                            child: Icon(Icons.check_rounded, size: 20, color: AppColors.secondaryColor10)),
                                      ),
                                    ],
                                  ) : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 50,
                                    child: ClipOval(
                                      child: CustomImageShimmer(
                                          imageUrl: iconUrl,
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                );
                              }) : Center(
                              child: Text('No Profile Icon',
                                  style: MainFonts.filterText(
                                      color:
                                      AppColors.lightTextColor))),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 10),
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryColor10,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(AppBoarderRadius.buttonRadius)),
                                  elevation: AppElevations.buttonElev,
                                ),
                                onPressed: () async {
                                  Future.delayed(
                                      const Duration(milliseconds: 300),
                                          () {
                                        Navigator.of(context).pop();
                                      });
                                },
                                child: Text('Update', style: AuthFonts.authButtonText())),
                          ),
                        ),
                      ],
                    ),
                  );
                }
            ));
  }
}
