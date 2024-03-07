import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  final List<String> wordsList;
  final int? maxLines;
  final TextOverflow overflow;
  final TextStyle defaultStyle;
  final TextStyle? highlightStyle;

  CustomRichText({
    Key? key,
    required this.wordsList,
    this.maxLines,
    required this.overflow,
    required this.defaultStyle,
    this.highlightStyle,
  }) : super(key: key);

  static trimString(String str){
    return str.trim();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      text: buildTextSpan(wordsList, defaultStyle, highlightStyle),
    );
  }

  static TextSpan buildTextSpan(List<String> wordsList, TextStyle defaultStyle, TextStyle? highlightStyle) {
    return TextSpan(
      children: [
        for (int i = 0; i < wordsList.length; i++) ...[
          TextSpan(
            text: wordsList[i],
            style: (wordsList[i].startsWith('@') && trimString(wordsList[i]).toString().length != 1) ? highlightStyle : defaultStyle,
          ),
        ],
      ],
    );
  }
}