import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review_app/features/reviews/presentation/widgets/bottom_sheet.dart';

dynamic suffixOfNumber(i) {
    var j = i % 10,
        k = i % 100;
    if (j == 1 && k != 11) {
        return i + "st";
    }
    if (j == 2 && k != 12) {
        return i + "nd";
    }
    if (j == 3 && k != 13) {
        return i + "rd";
    }
    return i + "th";
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