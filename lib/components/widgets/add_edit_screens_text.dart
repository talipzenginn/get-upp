import 'package:flutter/material.dart';
import '../../components/constants.dart';

class AddEditScreensText extends StatefulWidget {
  final String text;
  final double textSize;
  AddEditScreensText({this.text, this.textSize});
  @override
  _AddEditScreensTextState createState() => _AddEditScreensTextState();
}

class _AddEditScreensTextState extends State<AddEditScreensText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.center,
      style: TextStyle(color: kAddEditScreenTitle, fontSize: widget.textSize),
    );
  }
}
