import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/bottom_sheet.dart';

String suffixOfNumber(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
    return '$number' + 'th';
  }
  
  switch (number % 10) {
    case 1:
      return '$number' + 'st';
    case 2:
      return '$number' + 'nd';
    case 3:
      return '$number' + 'rd';
    default:
      return '$number' + 'th';
  }
}

void openBottomSheet(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)
            )
        ),
        builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.80,
          maxChildSize: 0.90,
          minChildSize: 0.70,
          builder: (context, scrollContoller) => SingleChildScrollView(
            controller: scrollContoller,
            child: SelectBottomSheet(index: index),
          ),
        ));
  }