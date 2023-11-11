import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/shadow.dart';

import '../../../../constants/boarder.dart';
import '../../../../constants/color.dart';
import '../../../../constants/cursor.dart';
import '../../../../utils/dropdown_items.dart';
import '../../../../utils/fonts.dart';

class BrandFilter extends StatefulWidget {
  const BrandFilter({super.key});

  @override
  State<BrandFilter> createState() => _BrandFilterState();
}

class _BrandFilterState extends State<BrandFilter> {
  TextEditingController brandController = TextEditingController();

  FocusNode _focusBrandNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
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
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                child: Text('Brand', style: MainFonts.lableText()),
              ),
              Autocomplete(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == "") {
                    return Items.brands;
                  }
                  return Items.brands.where((String element) {
                    return element
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase());
                  });
                },
                onSelected: (String item) {},
                optionsViewBuilder: ((context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      child: Container(
                        width: (MediaQuery.of(context).size.width) - 40,
                        height: 450,
                        color: AppColors.primaryColor30,
                        child: ListView.builder(
                          padding: EdgeInsets.all(6),
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            final String option = options.elementAt(index);

                            return InkWell(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                tileColor: AppColors.primaryColor30,
                                title:
                                    Text(option, style: MainFonts.suggestionText()),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }),
                fieldViewBuilder:
                    (context, textEditingController, focusNode, onFieldSubmitted) {
                  brandController = textEditingController;
                  _focusBrandNode = focusNode;

                  return Container(
                    decoration: BoxDecoration(boxShadow: ContainerShadow.boxShadow),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Field empty';
                        } else if (!(Items.brands.contains(value))) {
                          return 'Brand not exist';
                        }
                      }),
                      controller: brandController,
                      focusNode: _focusBrandNode,
                      onEditingComplete: onFieldSubmitted,
                      style: MainFonts.textFieldText(),
                      cursorHeight: TextCursorHeight.cursorHeight,
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.only(
                            top: 16, bottom: 16, left: 20, right: 20),
                        fillColor: AppColors.primaryColor30,
                        filled: true,
                        hintText: 'Select Brand',
                        hintStyle: MainFonts.hintFieldText(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.reviewUploadRadius),
                            borderSide: BorderSide(
                                width: AppBoarderWidth.reviewUploadWidth,
                                color: AppBoarderColor.searchBarColor)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.reviewUploadRadius),
                            borderSide: BorderSide(
                                width: AppBoarderWidth.reviewUploadWidth,
                                color: AppBoarderColor.searchBarColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.reviewUploadRadius),
                            borderSide: BorderSide(
                                width: AppBoarderWidth.searchBarWidth,
                                color: AppBoarderColor.searchBarColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                AppBoarderRadius.reviewUploadRadius),
                            borderSide: BorderSide(
                                width: AppBoarderWidth.searchBarWidth,
                                color: AppBoarderColor.errorColor)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
