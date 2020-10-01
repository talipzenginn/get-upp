import 'package:flutter/material.dart';
import '../../components/widgets/reusable_button.dart';

class PickColorButton extends StatefulWidget {
  final Function onTapFunction;
  final bool isIcon;
  final Color bodyColor;
  PickColorButton({this.onTapFunction, this.isIcon, this.bodyColor});

  @override
  _PickColorButtonState createState() => _PickColorButtonState();
}

class _PickColorButtonState extends State<PickColorButton> {
  @override
  Widget build(BuildContext context) {
    return ReusableButton(
      onTapFunction: widget.onTapFunction,
      isIcon: widget.isIcon,
      bodyColor: widget.bodyColor,
      borderColor: Color(0xFF048998),
      text: '',
      textSize: 0,
    );
  }
}
