import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final Function onTapfunction;
  final Color bodyColor;
  final String text;
  final double textSize;

  const ReusableButton({ this.onTapfunction, this.bodyColor, this.text, this.textSize});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap:onTapfunction,
        child: Container(
          decoration: BoxDecoration(color:bodyColor,
              border: Border.all(color: Colors.lightBlueAccent,),
              borderRadius: BorderRadius.circular(10.0)
          ),
          alignment: Alignment.center,
          height: 40.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize:textSize),
          ),
        ),
      ),
    );
  }
}
