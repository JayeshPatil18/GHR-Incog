import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final Text? title;
  final Text? content;
  final TextButton textButton1;
  final TextButton textButton2;

  const CustomDialogBox({super.key, required this.title, required this.content, required this.textButton1, required this.textButton2});

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: widget.title,
      content: widget.content,
      actions: <Widget>[
        widget.textButton1,
        widget.textButton2
      ],
    );
  }
}
