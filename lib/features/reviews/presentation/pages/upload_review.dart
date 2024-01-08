import 'dart:io';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:review_app/constants/values.dart';
import 'package:review_app/features/reviews/presentation/widgets/circle_button.dart';
import 'package:review_app/features/reviews/presentation/widgets/snackbar.dart';
import 'package:review_app/utils/dropdown_items.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../constants/elevation.dart';
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
  final FocusNode _focusPostTextNode = FocusNode();
  bool _hasPostTextFocus = false;
  TextEditingController postTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int hasImagePicked = -1;

  String? _validateInput(String? input, int index) {
    if (input != null) {
      input = input.trim();
    }

    switch (index) {
      case 0:
        if (input == null || input.isEmpty) {
          return 'Write confession';
        }
        break;

      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _focusPostTextNode.addListener(() {
      setState(() {
        _hasPostTextFocus = _focusPostTextNode.hasFocus;
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

  bool isLoading = false;

  setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
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
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
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
                                color: AppColors.textColor, size: 22),
                          ),
                          SizedBox(width: 10),
                          Text('Review', style: MainFonts.pageTitleText(fontSize: 24, weight: FontWeight.w400)),
                        ],
                      ),
                      Container(
                        height: 35,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondaryColor10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20)),
                              elevation: AppElevations.buttonElev,
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (!isLoading) {
                                setIsLoading(true);

                                bool isValid =
                                    _formKey.currentState!.validate();
                                if (isValid) {
                                  // Post Confession
                                }
                                setIsLoading(false);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: isLoading == false
                                  ? Text('Post',
                                      style: MainFonts.uploadButtonText(size: 16))
                                  : SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth:
                                          2,
                                          color:
                                          AppColors.primaryColor30))),
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 100, left: 10, right: 10),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('https://i.insider.com/61e9ac1cda4bc600181aaf63?width=700'),
                                  radius: 22,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: TextField(
                                    controller: postTextController,
                                    style: MainFonts.textFieldText(size: 20),
                                    decoration: InputDecoration(
                                      hintText: "Write fearlessly...",
                                      hintStyle: MainFonts.hintFieldText(size: 20, color: AppColors.transparentComponentColor),
                                      border: InputBorder.none,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              ],
                            ),
                            _selectedImage != null ? Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Image.file(_selectedImage!),
                            ) : SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.lightTextColor,
                        width: 0.3,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0).copyWith(
                          left: 15,
                          right: 15,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              pickSource();
                            },
                            child: Icon(Icons.photo_outlined, color: AppColors.secondaryColor10)
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
