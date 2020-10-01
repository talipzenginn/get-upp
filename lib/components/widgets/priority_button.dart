import 'package:flutter/material.dart';
import '../../components/constants.dart';
import '../../components/widgets/reusable_button.dart';

class PriorityButton extends StatelessWidget {
  final Function onTapFunction;
  final Color bodyColor;
  final String text;
  PriorityButton({this.onTapFunction, this.bodyColor, this.text});
  @override
  Widget build(BuildContext context) {
    return ReusableButton(
      onTapFunction: onTapFunction,
      bodyColor: bodyColor,
      text: text,
      textSize: 12.0,
      borderColor: kReusableButtonBody,
    );
  }
}
