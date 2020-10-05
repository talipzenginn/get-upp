import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import '../../components/constants.dart';

class ReusableButton extends StatelessWidget {
  final Function onTapFunction;
  final Color bodyColor;
  final String text;
  final double textSize;
  final Color borderColor;
  final bool isIcon;
  const ReusableButton(
      {this.onTapFunction,
      this.bodyColor,
      this.text,
      this.textSize,
      this.borderColor,
      this.isIcon = false});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapFunction,
        child: Container(
          decoration: BoxDecoration(
              color: bodyColor,
              border: Border.all(
                width: 1.4,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(10.0)),
          alignment: Alignment.center,
          height: 40.0,
          child: isIcon
              ? Icon(
                  FontAwesomeIcons.check,
                  color: Colors.white70,
                )
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: kReusableButtonText, fontSize: textSize),
                ),
        ),
      ),
    );
  }
}
